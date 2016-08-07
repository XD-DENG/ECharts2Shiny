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
                           running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

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

  # Generate legend
  legend_data <- paste(sapply(sort(unique(data$name)), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_data <- paste("[", legend_data, "]", sep="")

  # Convert raw data into JSON format
  data <- as.character(jsonlite::toJSON(data))
  data <- gsub("\"", "\'", data)

  js_statement <- paste("var " ,
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

                        ifelse(show.legend,
                               paste("legend:{orient: 'vertical', left: 'left', data:",
                                     legend_data,
                                     ", textStyle:{fontSize:", font.size.legend, "}",
                                     "},",
                                     sep=""),
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

                        sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({fluidPage(tags$script(\"",
                   js_statement,
                   "\"))})",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}


