
###########################################################################
# Internal Functions ------------------------------------------------------
###########################################################################

# This is a function defined to be used within user-level functions.
# It will help check if the theme argument is valid.
# If it's invalid, give error msg.
# if valid, return the theme place holder statement
.theme_placeholder <- function(theme){

  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")
  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  return(ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))
         )

}

# This is a function defined to help us tackle NA values in data
# In line charts and bar charts, if there is NA values in the data, the function can not work well as Javascript can NOT identify "NA" and it can only identify 'null'.
.process_NA <- function(data){
  data[is.na(data)] <- 'null'
  return(data)
}


# A function designed to help prepare data for heat map

.prepare_data_for_heatmap <- function(dat){
  n_row <- dim(dat)[1]
  n_col <- dim(dat)[2]

  temp <- c()
  for(i in 1:n_row){
    for(j in 1:n_col){
      temp <- c(temp, paste("[", i, ",", j, ",", dat[i,j], "]", sep=""))
    }
  }
  temp <- paste(temp, collapse = ", ")
  temp <- paste("[", temp, "]")
  return(temp)
}

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






###########################################################################
# Bar Chart ---------------------------------------------------------------
###########################################################################


renderBarChart <- function(div_id,
                           data, theme = "default",
                           stack_plot = FALSE,
                           direction = "horizontal",
                           grid_left = "3%", grid_right = "4%", grid_top = "16%", grid_bottom = "3%",
                           show.legend = TRUE, show.tools = TRUE,
                           font.size.legend = 12,
                           font.size.axis.x = 12, font.size.axis.y = 12,
                           rotate.axis.x = 0, rotate.axis.y = 0,
                           animation = TRUE,
                           running_in_shiny = TRUE){

  data <- isolate(data)

  data <- .process_NA(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Check if the "direction" value is valid
  if(direction == "horizontal"){
    direction_vector = c("xAxis", "yAxis")
  }else{
    if(direction == "vertical"){
      direction_vector = c("yAxis", "xAxis")
    }else{
      stop("The 'direction' argument can be either 'horizontal' or 'vertical'")
    }
  }

  xaxis_name <- paste(sapply(row.names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  xaxis_name <- paste("[", xaxis_name, "]", sep="")
  legend_name <- paste(sapply(names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_name <- paste("[", legend_name, "]", sep="")

  # Convert raw data into JSON format (Prepare the data in "series" part)
  series_data <- rep("", dim(data)[2])
  for(i in 1:length(series_data)){
    temp <- paste("{name:'", names(data)[i], "', type:'bar', ",
                  ifelse(stack_plot,
                         " stack:' ', ",
                         " "),
                  "data:[",
                  paste(data[, i], collapse = ", "),
                  "]}",
                  sep=""
    )
    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")
  series_data <- paste("[", series_data, "]", sep="")

  js_statement <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",

                  "option_", div_id,
                  " = {tooltip : {trigger:'axis', axisPointer:{type:'shadow'}}, ",

                  ifelse(show.tools,
                         "toolbox:{feature:{magicType:{type: ['stack', 'tiled']}, saveAsImage:{}}}, ",
                         ""),
                  
                  ifelse(animation,
                         "animation:true,",
                         "animation:false,"),

                  ifelse(show.legend,
                         paste("legend:{data:",
                               legend_name,
                               ", textStyle:{fontSize:", font.size.legend, "}",
                               "},",
                               sep=""),
                         ""),
                  "grid: {left:'", grid_left, "', right:'", grid_right, "', top:'", grid_top, "', bottom:'", grid_bottom, "', containLabel: true},",
                  direction_vector[1],
                  ":[{type:'value', axisLabel:{rotate:", rotate.axis.y, ",textStyle:{fontSize:", font.size.axis.y, "}}}], ",
                  direction_vector[2],
                  ":[{type:'category', axisTick:{show:false}, axisLabel:{rotate:", rotate.axis.x, ",textStyle:{fontSize:", font.size.axis.x, "}}, data:",
                  xaxis_name,
                  "}],series :",
                  series_data,
                  "};",

                  div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
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
                            rotate.axis.x = 0, rotate.axis.y = 0,
                            show.slider.axis.x = FALSE, show.slider.axis.y = FALSE,
                            animation = TRUE,
                            running_in_shiny = TRUE){

  data <- isolate(data)

  data <- .process_NA(data)

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

  xaxis_name <- paste(sapply(row.names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  xaxis_name <- paste("[", xaxis_name, "]", sep="")
  legend_name <- paste(sapply(names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_name <- paste("[", legend_name, "]", sep="")

  step_statement <- ifelse(step == 'null',
                           "step:false,",
                           paste("step:'", step, "',", sep = ""))

  # Convert raw data into JSON format
  series_data <- rep("", dim(data)[2])
  for(i in 1:length(series_data)){
    temp <- paste("{name:'", names(data)[i], "', type:'line', ",

                  step_statement,

                  paste("symbolSize:", point.size[i], ",", sep=""),
                  paste("symbol:'", point.type[i], "',", sep=""),

                  "itemStyle:{normal:{lineStyle: {width:", line.width[i],", type:'", line.type[i], "'}}},",

                  ifelse(stack_plot,
                         "stack: ' ', areaStyle: {normal: {}},",
                         " "),
                  "data:[",
                  paste(data[, i], collapse = ", "),
                  "]}",
                  sep=""
    )
    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")


  js_statement <- paste("var " ,
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

                  ifelse(show.slider.axis.x == TRUE & show.slider.axis.y == FALSE,
                         "dataZoom: [{type:'slider', xAxisIndex : 0}],",
                         ifelse(show.slider.axis.x == FALSE & show.slider.axis.y == TRUE,
                                "dataZoom: [{type:'slider', yAxisIndex : 0}],",
                                ifelse(show.slider.axis.x == TRUE & show.slider.axis.y == TRUE,
                                       "dataZoom: [{type:'slider', xAxisIndex : 0},{type:'slider',yAxisIndex:0}],",
                                       'dataZoom: [],')
                         )),

                  ifelse(show.legend,
                         paste("legend:{data:",
                               legend_name,
                               ", textStyle:{fontSize:", font.size.legend, "}",
                               "},",
                               sep=""),
                         ""),
                  
                  ifelse(animation,
                         "animation:true,",
                         "animation:false,"),
                  
                  "yAxis: { type: 'value', axisLabel:{rotate:",rotate.axis.y,",textStyle:{fontSize:", font.size.axis.y, "}}}, ",
                  "xAxis:{type:'category', boundaryGap: false, axisLabel:{rotate:", rotate.axis.x, ",textStyle:{fontSize:", font.size.axis.x, "}}, data:",
                  xaxis_name,
                  "}, series:[",
                  series_data,
                  "]};",

                  div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
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





###########################################################################
# Gauge -------------------------------------------------------------------
###########################################################################


renderGauge <- function(div_id, theme = "default",
                        gauge_name, rate,
                        show.tools = TRUE,
                        animation = TRUE,
                        running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Convert raw data into JSON format
  series_data <- paste("[{name:'",gauge_name, "',value:", rate, "}]", sep="")

  js_statement <- paste("var ",
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",

                  "option_", div_id, "={tooltip : {formatter: '{b} : {c}%'}, ",

                  ifelse(show.tools,
                         "toolbox: {feature: {saveAsImage: {}}},",
                         ""),

                  ifelse(animation,
                         "animation:true,",
                         "animation:false,"),
                  
                  "series:[{name:'", gauge_name, "', type:'gauge', detail: {formatter:'{value}%'},data:",
                  series_data,
                  "}]};",

                  div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
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





###########################################################################
# Scatter -----------------------------------------------------------------
###########################################################################


renderScatter <- function(div_id, data,
                          point.size = 10, point.type = "circle",
                          theme = "default", auto.scale = TRUE,
                          show.legend = TRUE, show.tools = TRUE,
                          font.size.legend = 12,
                          font.size.axis.x = 12, font.size.axis.y = 12,
                          rotate.axis.x = 0, rotate.axis.y = 0,
                          show.slider.axis.x = FALSE, show.slider.axis.y = FALSE,
                          animation = TRUE,
                          running_in_shiny = TRUE){

  data <- isolate(data)

  if(sum(is.na(data)) > 0 & auto.scale == FALSE){
    auto.scale <- TRUE
    warning("auto.scale must be on when there is any N.A. values in the data.")
  }

  data <- .process_NA(data)

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

  legend_name <- paste(sapply(group_names, function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_name <- paste("[", legend_name, "]", sep="")


  # Convert raw data into JSON format (Prepare the data in "series" part)
  series_data <- rep("", length(group_names))
  for(i in 1:length(group_names)){

    temp_data <- data[data$group == group_names[i],]

    temp <- paste("{name:'", group_names[i], "', type:'scatter', ",

                  paste("symbolSize:", point.size, ",", sep=""),
                  paste("symbol:'", point.type[i], "',", sep=""),

                  "data:[",
                  paste(sapply(1:dim(temp_data)[1],
                               function(j){
                                 paste("[", temp_data[j, "x"],
                                       ",",
                                       temp_data[j, "y"],"]",
                                       sep="")
                               }),
                        collapse = ","),
                  "]}",
                  sep="")
    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")
  series_data <- paste("[", series_data, "]", sep="")


  js_statement <- paste("var " ,
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

                  ifelse(show.legend,
                         paste("legend:{data:",
                               legend_name,
                               ", textStyle:{fontSize:", font.size.legend, "}",
                               "},",
                               sep=""),
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

                         paste("xAxis:[{type : 'value',scale:true, axisLabel:{rotate:",
                               rotate.axis.x,
                               ",textStyle:{fontSize:",
                               font.size.axis.x,
                               "}}}],",
                               "yAxis:[{type : 'value',scale:true,axisLabel:{rotate:",
                               rotate.axis.y,
                               ",textStyle:{fontSize:",
                               font.size.axis.y,
                               "}}}],", sep=""),

                         paste("xAxis:[{gridIndex: 0, axisLabel:{rotate:", rotate.axis.x, ",textStyle:{fontSize:", font.size.axis.x, "}}, min: ",
                               round(min(data$x) - 0.03 * diff(range(data$x)), 1) - 0.1,
                               ", max: ",
                               round(max(data$x) + 0.03 * diff(range(data$x)), 1) + 0.1,
                               "}],yAxis:[{gridIndex: 0, axisLabel:{rotate:", rotate.axis.y, ",textStyle:{fontSize:", font.size.axis.y, "}}, min: ",
                               round(min(data$y) - 0.03 * diff(range(data$y)), 1) - 0.1,
                               ", max: ",
                               round(max(data$y) + 0.03 * diff(range(data$y)), 1) + 0.1,
                               "}],",
                               sep="")
                         ),

                  "series :",
                  series_data,
                  "};",

                  div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
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






###########################################################################
# Radar Charts ------------------------------------------------------------
###########################################################################


renderRadarChart <- function(div_id,
                           data, theme = "default",
                           shape = "default", line.width = 2,
                           show.legend = TRUE, show.tools = TRUE,
                           font.size.legend = 12,
                           animation = TRUE,
                           running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # check the value for "shape"
  valid_shapes <- c("default", "circle")
  if((shape %in% valid_shapes) == FALSE){
    stop("The shape is invalid. You can choose 'default' or 'circle'.")
  }


  legend_data <- paste(sapply(names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_data <- paste("[", legend_data, "]", sep="")

  indicator <- paste(sapply(1:dim(data)[1],
                            function(i){
                              paste("{name:'", row.names(data)[i],
                                    "', max:",
                                    max(data[i,])*1.1,
                                    "}",
                                    sep="")
                            }),
                     collapse = ",")
  indicator <- paste("indicator:[",
                     indicator,
                     "]")

  # Convert raw data into JSON format
  data <- paste(sapply(1:dim(data)[2],
                       function(i){
                         paste("{value:[",
                               paste(data[, i], collapse = ","),
                               "], name:'",
                               names(data)[i],
                               "'}",
                               sep="")
                       }),
                collapse = ",")


  js_statement <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",
                  "option_", div_id, " = {tooltip:{}, ",

                  ifelse(show.tools,
                         "toolbox:{feature:{saveAsImage:{}}}, ",
                         ""),
                  
                  ifelse(animation,
                         "animation:true,",
                         "animation:false,"),

                  ifelse(show.legend,
                         paste("legend:{orient: 'vertical', left: 'left', data:",
                               legend_data,
                               ", textStyle:{fontSize:", font.size.legend, "}",
                               "},",
                               sep=""),
                         ""),
                  "radar:{",
                  ifelse(shape == "default",
                         "",
                         "shape: 'circle',"),
                  indicator,
                  "},",
                  "series : [{type: 'radar',",
                  "data:[",
                  data,
                  "], itemStyle: {normal:{lineStyle: {width:", line.width, "}},emphasis : {areaStyle: {color:'rgba(0,250,0,0.3)'}}}}]};",

                  div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
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





###########################################################################
# Heat Map ----------------------------------------------------------------
###########################################################################

renderHeatMap <- function(div_id, data,
                          theme = "default",
                          show.tools = TRUE,
                          running_in_shiny = TRUE){

  data <- isolate(data)

  if((is.matrix(data) == FALSE) | ((class(data[1, 1]) %in% c("numeric", "integer")) == FALSE)){
    stop("The data input must be a matrix containing numeric or integer values")
  }

  # This is to process NA values. If there is NA values, it will be changed into "null" to be consistent with Javascript
  # The values in the matrix will turn to be "character". This is also why we save it separately as a new variable (we still need the NUMERIC values in the raw data to compute max and min values)
  processed_data <- .process_NA(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Convert raw data into JSON format
  series_data <- paste("[{type: 'heatmap',data:", .prepare_data_for_heatmap(processed_data), ",itemStyle: {emphasis: {shadowBlur: 10,shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]", sep="")

  # prepare axis labels

  row_names <- row.names(data)
  col_names <- colnames(data)


  js_statement <- paste("var ",
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",

                        "option_", div_id, "={tooltip:{position: 'top'}, ",

                        ifelse(show.tools,
                               "toolbox: {feature: {saveAsImage: {}}},",
                               ""),

                        "xAxis: {type: 'category',data: [",
                        ifelse(is.null(row_names),
                               "' '",
                               paste(sapply(row_names,
                                            function(x){
                                              paste("'", x, "'", sep="")
                                            }), collapse = ",")),
                        "],splitArea: {show: true}},",


                        "yAxis: {type: 'category',data: [",
                        ifelse(is.null(col_names),
                               "' '",
                               paste(sapply(col_names,
                                            function(x){
                                              paste("'", x, "'", sep="")
                                            }), collapse = ",")),
                        "],splitArea: {show: true}},",

                        "visualMap: {min: ", min(data[is.na(data)==FALSE]), ",max: ", max(data[is.na(data)==FALSE]), ",bottom: '15%', show:false},",

                        "series:",
                        series_data,
                        "};",

                        div_id,
                        ".setOption(option_",
                        div_id,
                        ");",
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
