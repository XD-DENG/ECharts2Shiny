###########################################################################
# Word Cloud ------------------------------------------------------------
###########################################################################


renderWordcloud <- function(div_id,
                            data, shape = "circle",
                            grid_size = 5,
                            sizeRange = c(15, 50),
                            rotationRange = c(-45, 45),
                            hyperlinks = NULL,
                            running_in_shiny = TRUE){

  data <- isolate(data)




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
    stop("'hyperlinks' feature doesn't support vector data in word cloud for now. Only data.frame data is supported.")
  }

  # Check if the length of "hyperlink" is the same as the length of the x-axis names
  if(is.null(hyperlinks) == FALSE){
    item_names <- data$name
    if((length(hyperlinks) != length(item_names)) & (is.null(hyperlinks) == FALSE)){
      stop("The length of 'hyperlinks' should be the same as the number of items in the word cloud.")
    }
  }



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

  # Check logical variables (whether they're logical)
  .check_logical(c('running_in_shiny'))




  # Convert raw data into JSON format
  js_data <- as.character(jsonlite::toJSON(data))
  js_data <- gsub("\"", "\'", js_data)


  js_statement <- paste("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "'));",

                        "option_", div_id,
                        "= {tooltip:{",
                        ifelse(is.null(hyperlinks),
                               "",
                               "textStyle: {fontStyle:'italic', color:'skyblue'}"),
                        "},",

                        "series:[{type: 'wordCloud',gridSize: ", grid_size, ",",
                        "sizeRange:", paste("[", sizeRange[1], ",", sizeRange[2], "]", sep=""), ",",
                        "rotationRange:", paste("[", rotationRange[1], ",", rotationRange[2], "]", sep=""), ",",
                        "shape: '", shape, "',width: 600,height: 500,
                        textStyle: {normal: {color:function (){return 'rgb(' + [Math.round(Math.random() * 200),Math.round(Math.random() * 200),Math.round(Math.random() * 200)].join(',') + ')';}},
                        emphasis: {
                        shadowBlur: 30,
                        shadowColor: '#333'
                        }},
                        data:",
                        js_data,
                        "}]};",
                        div_id,
                        ".setOption(option_",
                        div_id,
                        ");",

                        "window.addEventListener('resize', function(){",
                        div_id, ".resize()",
                        "});",

                        ifelse(is.null(hyperlinks),
                               "",
                               paste(div_id,
                                     ".on('click', function (param){
                                     var name=param.name;",

                                     paste(sapply(1:length(hyperlinks),
                                                  function(i){
                                                    paste("if(name=='", item_names[i], "'){",
                                                          "window.location.href='", hyperlinks[i], "';}",
                                                          sep="")
                                                  }),
                                           collapse = ""),

                                     "});",
                                     div_id, ".on('click');",
                                     sep="")
                        ),

                        sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({tags$script(\"",
                   js_statement,
                   "\")})",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}
