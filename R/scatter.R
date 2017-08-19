###########################################################################
# Scatter -----------------------------------------------------------------
###########################################################################


renderScatter <- function(div_id, data,
                          point.size = 10, point.type = "circle",
                          theme = "default", auto.scale = TRUE,
                          show.legend = TRUE, show.tools = TRUE,
                          font.size.legend = 12,
                          font.size.axis.x = 12, font.size.axis.y = 12,
                          axis.x.name = NULL, axis.y.name = NULL,
                          rotate.axis.x = 0, rotate.axis.y = 0,
                          show.slider.axis.x = FALSE, show.slider.axis.y = FALSE,
                          animation = TRUE,
                          grid_left = "3%", grid_right = "4%", grid_top = "16%", grid_bottom = "3%",
                          running_in_shiny = TRUE){

  data <- isolate(data)

  if(sum(is.na(data)) > 0 & auto.scale == FALSE){
    auto.scale <- TRUE
    warning("auto.scale must be on when there is any N.A. values in the data.")
  }

  data <- .process_NA(data)

  # Check logical variables (whether they're logical)
  .check_logical(c('auto.scale', 'show.tools', 'show.legend', 'animation',
                   'show.slider.axis.x', 'show.slider.axis.y', 'running_in_shiny'))

  # DATA PREPARATION:
  # For scatter plots, the data must be prepared as a data.frame of 3 columns.
  # "x", "y", and "group"
  if(dim(data)[2] !=3 )
    stop("The data must be made up of three columns, 'x', 'y', and 'group'")

  if(sum(sapply(c("x", "y", "group"), function(x){x %in% names(data)})) != 3)
    stop("The data must be made up of three columns, 'x', 'y', and 'group'")

  # check the value of point.size
  if((class(point.size) %in% c("numeric", "integer")) == FALSE){
    stop("The point.size should either be numeric or integer.")
  }

  # Check the value of theme
  theme_placeholder <- .theme_placeholder(theme)

  # check the value of point.type
  unique_point.types <- unique(point.type)
  if(sum(sapply(unique_point.types, function(x){x %in% c('emptyCircle', 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow')})) != length(unique_point.types)){
    stop("The point.type can only be 'emptyCircle', 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow'.")
  }

  n_of_category <- dim(data)[2]
  # Check the length of point.type
  if(length(point.type) != 1){
    if(length(point.type) != n_of_category){
      stop("The length of point.type should either be one or the same as the number of categories.")
    }
  } else {
    point.type <- rep(point.type, n_of_category)
  }


  # get the unique values of "group" column
  group_names <- sort(unique(data$group))

  legend_name <- paste(sapply(group_names, function(x){paste0("'", x, "'")}), collapse=", ")
  legend_name <- paste0("[", legend_name, "]")


  # Convert raw data into JSON format (Prepare the data in "series" part)
  series_data <- rep("", length(group_names))
  for(i in 1:length(group_names)){

    temp_data <- data[data$group == group_names[i],]

    temp <- paste0("{name:'", group_names[i], "', type:'scatter', ",

                  paste0("symbolSize:", point.size, ","),
                  paste0("symbol:'", point.type[i], "',"),

                  "data:[",
                  paste(sapply(1:dim(temp_data)[1],
                               function(j){
                                 paste0("[", temp_data[j, "x"],
                                       ",",
                                       temp_data[j, "y"],"]")
                               }),
                        collapse = ","),
                  "]}")
    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")
  series_data <- paste0("[", series_data, "]")


  js_statement <- paste0("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",

                        "option_", div_id,
                        " = {tooltip : {trigger:'axis', axisPointer:{show: true, type:'cross'}}, ",
                        ifelse(show.tools,
                               "toolbox:{feature:{dataZoom:{show: true},restore:{show: true},saveAsImage:{show: true}}}, ",
                               ""),

                        "grid: {left:'", grid_left, "', right:'", grid_right, "', top:'", grid_top, "', bottom:'", grid_bottom, "', containLabel: true},",

                        ifelse(show.legend,
                               paste0("legend:{data:",
                                     legend_name,
                                     ", textStyle:{fontSize:", font.size.legend, "}",
                                     "},"),
                               ""),

                        ifelse(animation,
                               "animation:true,",
                               "animation:false,"),

                        ifelse(show.slider.axis.x == TRUE & show.slider.axis.y == FALSE,
                               "dataZoom: [{type:'slider', xAxisIndex : 0}],",
                               ifelse(show.slider.axis.x == FALSE & show.slider.axis.y == TRUE,
                                      "dataZoom: [{type:'slider', yAxisIndex : 0}],",
                                      ifelse(show.slider.axis.x == TRUE & show.slider.axis.y == TRUE,
                                             "dataZoom: [{type:'slider', xAxisIndex : 0},{type:'slider',yAxisIndex:0}],",
                                             'dataZoom: [],')
                               )),

                        ifelse(auto.scale,

                               paste0("xAxis:[{type : 'value', name:", ifelse(is.null(axis.x.name), 'null', paste0("'", axis.x.name, "'")), ", scale:true, axisLabel:{rotate:",
                                     rotate.axis.x,
                                     ",textStyle:{fontSize:",
                                     font.size.axis.x,
                                     "}}}],",
                                     "yAxis:[{type:'value', name:", ifelse(is.null(axis.y.name), 'null', paste0("'", axis.y.name, "'")), ", scale:true,axisLabel:{rotate:",
                                     rotate.axis.y,
                                     ",textStyle:{fontSize:",
                                     font.size.axis.y,
                                     "}}}],"),

                               paste0("xAxis:[{gridIndex: 0, axisLabel:{rotate:", rotate.axis.x, ",textStyle:{fontSize:", font.size.axis.x, "}}, min: ",
                                     round(min(data$x) - 0.03 * diff(range(data$x)), 1) - 0.1,
                                     ", max: ",
                                     round(max(data$x) + 0.03 * diff(range(data$x)), 1) + 0.1,
                                     "}],yAxis:[{gridIndex: 0, axisLabel:{rotate:", rotate.axis.y, ",textStyle:{fontSize:", font.size.axis.y, "}}, min: ",
                                     round(min(data$y) - 0.03 * diff(range(data$y)), 1) - 0.1,
                                     ", max: ",
                                     round(max(data$y) + 0.03 * diff(range(data$y)), 1) + 0.1,
                                     "}],")
                        ),

                        "series :",
                        series_data,
                        "};",

                        div_id,
                        ".setOption(option_",
                        div_id,
                        ");",

                        "window.addEventListener('resize', function(){",
                        div_id, ".resize()",
                        "});")

  to_eval <- paste0("output$", div_id ," <- renderUI({tags$script(\"",
                   js_statement,
                   "\")})")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }

}
