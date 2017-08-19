###########################################################################
# Line Chart --------------------------------------------------------------
###########################################################################

renderLineChart <- function(div_id,
                            data, theme = "default",
                            line.width = 2, line.type = "solid",
                            point.size = 5, point.type = "emptyCircle",
                            stack_plot = FALSE, step = "null",
                            show.legend = TRUE, show.tools = TRUE,
                            font.size.legend =12,
                            font.size.axis.x = 12, font.size.axis.y = 12,
                            axis.x.name = NULL, axis.y.name = NULL,
                            rotate.axis.x = 0, rotate.axis.y = 0,
                            show.slider.axis.x = FALSE, show.slider.axis.y = FALSE,
                            animation = TRUE,
                            grid_left = "3%", grid_right = "4%", grid_top = "16%", grid_bottom = "3%",
                            running_in_shiny = TRUE){

  data <- isolate(data)

  data <- .process_NA(data)

  # Check logical variables (whether they're logical)
  .check_logical(c('stack_plot', 'show.tools', 'show.legend', 'animation',
                   'show.slider.axis.x', 'show.slider.axis.y', 'running_in_shiny'))

  # check the type of line.width
  if((class(line.width) %in% c("numeric", "integer")) == FALSE){
    stop("The line.width should either be numeric or integer.")
  }

  # check the type of point.size
  if((class(point.size) %in% c("numeric", "integer")) == FALSE){
    stop("The point.size should either be numeric or integer.")
  }

  # check the value of point.type
  unique_point.types <- unique(point.type)
  if(sum(sapply(unique_point.types, function(x){x %in% c('emptyCircle', 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow')})) != length(unique_point.types)){
    stop("The point.type can only be 'emptyCircle', 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow'.")
  }

  # check the value of line.type
  unique_line.types <- unique(line.type)
  if(sum(sapply(unique_line.types, function(x){x %in% c("solid", "dashed", "dotted")})) != length(unique_line.types)){
    stop("The line.type can only be 'solid', 'dashed', or 'dotted'.")
  }

  # check the value of 'step'
  if((step %in% c('null', 'start', 'middle', 'end')) == FALSE){
    stop("The 'step' can only be 'null', 'start', 'middle' or 'end'.")
  }


  n_of_category <- dim(data)[2]
  # Check the length of line.width
  if(length(line.width) != 1){
    if(length(line.width) != n_of_category){
      stop("The length of line.width should either be one or the same as the number of categories.")
    }
  } else {
    line.width <- rep(line.width, n_of_category)
  }

  # check the length of line.type
  if(length(line.type) != 1){
    if(length(line.type) != n_of_category){
      stop("The length of line.type should either be one or the same as the number of categories.")
    }
  } else {
    line.type <- rep(line.type, n_of_category)
  }

  # Check the length of point.size
  if(length(point.size) != 1){
    if(length(point.size) != n_of_category){
      stop("The length of point.size should either be one or the same as the number of categories.")
    }
  } else {
    point.size <- rep(point.size, n_of_category)
  }

  # Check the length of point.type
  if(length(point.type) != 1){
    if(length(point.type) != n_of_category){
      stop("The length of point.type should either be one or the same as the number of categories.")
    }
  } else {
    point.type <- rep(point.type, n_of_category)
  }

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  xaxis_name <- paste(sapply(row.names(data), function(x){paste0("'", x, "'")}), collapse=", ")
  xaxis_name <- paste0("[", xaxis_name, "]")
  legend_name <- paste(sapply(names(data), function(x){paste0("'", x, "'")}), collapse=", ")
  legend_name <- paste0("[", legend_name, "]")

  step_statement <- ifelse(step == 'null',
                           "step:false,",
                           paste("step:'", step, "',", sep = ""))

  # Convert raw data into JSON format
  series_data <- rep("", dim(data)[2])
  for(i in 1:length(series_data)){
    temp <- paste0("{name:'", names(data)[i], "', type:'line', ",

                  step_statement,

                  paste0("symbolSize:", point.size[i], ","),
                  paste0("symbol:'", point.type[i], "',"),

                  "itemStyle:{normal:{lineStyle: {width:", line.width[i],", type:'", line.type[i], "'}}},",

                  ifelse(stack_plot,
                         "stack: ' ', areaStyle: {normal: {}},",
                         " "),
                  "data:[",
                  paste(data[, i], collapse = ", "),
                  "]}")

    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")


  js_statement <- paste0("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",
                        "option_", div_id, " = {tooltip : {trigger: 'axis'}, ",

                        ifelse(show.tools,
                               "toolbox:{feature:{saveAsImage:{}}}, ",
                               ""),

                        "grid: {left:'", grid_left, "', right:'", grid_right, "', top:'", grid_top, "', bottom:'", grid_bottom, "', containLabel: true},",

                        ifelse(show.slider.axis.x == TRUE & show.slider.axis.y == FALSE,
                               "dataZoom: [{type:'slider', xAxisIndex : 0}],",
                               ifelse(show.slider.axis.x == FALSE & show.slider.axis.y == TRUE,
                                      "dataZoom: [{type:'slider', yAxisIndex : 0}],",
                                      ifelse(show.slider.axis.x == TRUE & show.slider.axis.y == TRUE,
                                             "dataZoom: [{type:'slider', xAxisIndex : 0},{type:'slider',yAxisIndex:0}],",
                                             'dataZoom: [],')
                               )),

                        ifelse(show.legend,
                               paste0("legend:{data:",
                                     legend_name,
                                     ", textStyle:{fontSize:", font.size.legend, "}",
                                     "},"),
                               ""),

                        ifelse(animation,
                               "animation:true,",
                               "animation:false,"),

                        "yAxis:{type: 'value', name:", ifelse(is.null(axis.y.name), 'null', paste0("'", axis.y.name, "'")), ", axisLabel:{rotate:",rotate.axis.y,",textStyle:{fontSize:", font.size.axis.y, "}}}, ",
                        "xAxis:{type:'category', name:", ifelse(is.null(axis.x.name), 'null', paste0("'", axis.x.name, "'")), ", boundaryGap: false, axisLabel:{rotate:", rotate.axis.x, ",textStyle:{fontSize:", font.size.axis.x, "}}, data:",
                        xaxis_name,
                        "}, series:[",
                        series_data,
                        "]};",

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
