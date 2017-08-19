###########################################################################
# Pie Chart ---------------------------------------------------------------
###########################################################################

renderPieChart <- function(div_id,
                           data, theme = "default",
                           radius = "50%",
                           center_x = "50%", center_y = "50%",
                           show.label = TRUE,
                           show.legend = TRUE, show.tools = TRUE,
                           font.size.legend = 12,
                           animation = TRUE,
                           hyperlinks = NULL,
                           running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Check logical variables (whether they're logical)
  .check_logical(c('show.label', 'show.tools', 'show.legend', 'animation', 'running_in_shiny'))

  # Check if the data source support "hyperlink" feature is user is using "hyperlink" feature
  # this is due to that the program will convert vector data into data.frame,
  # and the order may dismatch with the vector given for "hyperlink".
  # for example, the data may be
  # dat <- c(rep("Google", 8),
  #            rep("Bing", 5),
  #            rep("Baidu", 1))
  # and we should give "hyperlink" as c(<URL for Google>, <URL for Bing>, <URL for Baidu>)
  # but the data.frame derived from the vector may list these three elements in different order
  if(is.vector(data) & (is.null(hyperlinks) == FALSE)){
    stop("'hyperlinks' feature doesn't support vector data for now. Only data.frame data is supported.")
  }


  # Check if the data input is valid
  # the data input should be either a vector or a data.frame meeting specific requirement.
  if(is.vector(data)){
    data <- data.frame(table(data))
    names(data) <- c("name", "value")
  } else {
    # Check if the data is valid
    if((dim(data)[2] != 2) | ("name" %in% names(data) == FALSE) | ("value" %in% names(data) == FALSE)){
      stop("The data must be made up of two columns, 'name' and 'value'")
    }

    # check if the "value" column is numeric
    if(class(data$value) != 'numeric' & class(data$value) != 'integer'){
      stop("The 'value' column must be numeric or integer.")
    }
  }

  # Check if the length of "hyperlink" is the same as the length of the x-axis names
  if(is.null(hyperlinks) == FALSE){
    item_names <- data$name
    if((length(hyperlinks) != length(item_names)) & (is.null(hyperlinks) == FALSE)){
      stop("The length of 'hyperlinks' should be the same as the number of unique items in the pie chart.")
    }
  }


  # Generate legend
  legend_data <- paste(sapply(sort(unique(data$name)), function(x){paste0("'", x, "'")}), collapse=", ")
  legend_data <- paste0("[", legend_data, "]")

  # Convert raw data into JSON format
  data <- as.character(jsonlite::toJSON(data))
  data <- gsub("\"", "\'", data)

  js_statement <- paste0("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",

                        "option_", div_id, " = {tooltip : {trigger: 'item',formatter: '{b} : {c} ({d}%)'}, ",

                        ifelse(show.tools,
                               "toolbox:{feature:{saveAsImage:{}}}, ",
                               ""),

                        ifelse(is.null(hyperlinks),
                               "",
                               "tooltip : {textStyle: {fontStyle:'italic', color:'skyblue'}},"),

                        ifelse(show.legend,
                               paste0("legend:{orient: 'vertical', left: 'left', data:",
                                     legend_data,
                                     ", textStyle:{fontSize:", font.size.legend, "}",
                                     "},"),
                               ""),
                        "series : [{type: 'pie', radius:'", radius, "', center :['", center_x, "','", center_y, "'],",

                        ifelse(show.label,
                               "label:{normal:{show: true}},",
                               "label:{normal:{show: false}},"),

                        ifelse(animation,
                               "animation:true,",
                               "animation:false,"),

                        "data:",
                        data,
                        ", itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]};",

                        div_id,
                        ".setOption(option_",
                        div_id,
                        ");",

                        "window.addEventListener('resize', function(){",
                        div_id, ".resize()",
                        "});",

                        ifelse(is.null(hyperlinks),
                               "",
                               paste0(div_id,
                                     ".on('click', function (param){
                                     var name=param.name;",

                                     paste(sapply(1:length(hyperlinks),
                                                  function(i){
                                                    paste0("if(name=='", item_names[i], "'){",
                                                          "window.location.href='", hyperlinks[i], "';}")
                                                  }),
                                           collapse = ""),

                                     "});",
                                     div_id, ".on('click');")
                        ))

  to_eval <- paste0("output$", div_id ," <- renderUI({tags$script(\"",
                   js_statement,
                   "\")})")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}


