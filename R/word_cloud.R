###########################################################################
# Word Cloud ------------------------------------------------------------
###########################################################################


renderWordcloud <- function(div_id,
                            data, shape = "circle",
                            grid_size = 5,
                            sizeRange = c(15, 50),
                            rotationRange = c(-45, 45),
                            running_in_shiny = TRUE){

  data <- isolate(data)

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

  # Convert raw data into JSON format
  js_data <- as.character(jsonlite::toJSON(data))
  js_data <- gsub("\"", "\'", js_data)


  js_statement <- paste("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "'));",

                        "option_", div_id,
                        "= {tooltip:{},",

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
