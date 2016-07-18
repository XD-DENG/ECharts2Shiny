
###########################################################################
# Pie Chart ---------------------------------------------------------------
###########################################################################

renderPieChart <- function(div_id,
                           data, theme = "default",
                           radius = "50%",
                           center_x = "50%", center_y = "50%",
                           show.legend = TRUE, show.tools = TRUE,
                           running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

  legend_data <- paste(sapply(names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_data <- paste("[", legend_data, "]", sep="")

  data <- data.frame(t(data))
  names(data) <- "value"
  data$name <- row.names(data)
  row.names(data) <- NULL
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
                               legend_data,  "},",
                               sep=""),
                         ""),
                  "series : [{type: 'pie', radius:'", radius, "', center :['", center_x, "','", center_y, "'],",

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
                           running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

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

  # Prepare the data in "series" part
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

                  ifelse(show.legend,
                         paste("legend:{data:",
                               legend_name, "},",
                               sep=""),
                         ""),
                  "grid: {left:'", grid_left, "', right:'", grid_right, "', top:'", grid_top, "', bottom:'", grid_bottom, "', containLabel: true},",
                  direction_vector[1],
                  ":[{type:'value'}], ",
                  direction_vector[2],
                  ":[{type:'category', axisTick:{show:false}, data:",
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
                            stack_plot = FALSE,
                            show.legend = TRUE, show.tools = TRUE,
                            running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

  xaxis_name <- paste(sapply(row.names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  xaxis_name <- paste("[", xaxis_name, "]", sep="")
  legend_name <- paste(sapply(names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_name <- paste("[", legend_name, "]", sep="")

  series_data <- rep("", dim(data)[2])
  for(i in 1:length(series_data)){
    temp <- paste("{name:'", names(data)[i], "', type:'line', ",
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

                  ifelse(show.legend,
                         paste("legend:{data:",
                               legend_name,
                               "},",
                               sep=""),
                         ""),
                  "yAxis: { type: 'value'}, xAxis:{type:'category', boundaryGap: false, data:",
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
                        running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

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
                          theme = "default", auto.scale = TRUE,
                          show.legend = TRUE, show.tools = TRUE,
                          running_in_shiny = TRUE){

  data <- isolate(data)

  # DATA PREPARATION:
  # For scatter plots, the data must be prepared as a data.frame of 3 columns.
  # "x", "y", and "group"
  if(dim(data)[2] !=3 )
    stop("The data must be made up of three columns, 'x', 'y', and 'group'")

  if(sum(sapply(c("x", "y", "group"), function(x){x %in% names(data)})) != 3)
    stop("The data must be made up of three columns, 'x', 'y', and 'group'")


  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

  # get the unique values of "group" column
  group_names <- sort(unique(data$group))

  legend_name <- paste(sapply(group_names, function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_name <- paste("[", legend_name, "]", sep="")




  # Prepare the data in "series" part
  series_data <- rep("", length(group_names))
  for(i in 1:length(group_names)){

    temp_data <- data[data$group == group_names[i],]

    temp <- paste("{name:'", group_names[i], "', type:'scatter', ",
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
                               legend_name, "},",
                               sep=""),
                         ""),

                  ifelse(auto.scale,
                         "xAxis:[{type : 'value',scale:true}],yAxis:[{type : 'value',scale:true}],",
                         paste("xAxis:[{gridIndex: 0, min: ",
                               # min(data$x) - 0.03 * diff(range(data$x)),
                               round(min(data$x) - 0.03 * diff(range(data$x)), 1) - 0.1,
                               ", max: ",
                               # max(data$x) + 0.03 * diff(range(data$x)),
                               round(max(data$x) + 0.03 * diff(range(data$x)), 1) + 0.1,
                               "}],yAxis:[{gridIndex: 0, min: ",
                               # min(data$y) - 0.03 * diff(range(data$y)),
                               round(min(data$y) - 0.03 * diff(range(data$y)), 1) - 0.1,
                               ", max: ",
                               # max(data$y) + 0.03 * diff(range(data$y)),
                               round(max(data$y) + 0.03 * diff(range(data$y)), 1) + 0.1,
                               "}],",
                               sep="")),

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
                           running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")
  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  # check the value for "sahpe"

  valid_shapes <- c("default", "circle")
  if((shape %in% valid_shapes) == FALSE){
    stop("The shape is invalid. You can choose 'default' or 'circle'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

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

                  ifelse(show.legend,
                         paste("legend:{orient: 'vertical', left: 'left', data:",
                               legend_data,  "},",
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
# Wordcloud
###########################################################################


renderWordcloud <- function(div_id,
                            data,
                            grid_size = 5,
                            sizeRange = c(15, 50),
                            rotationRange = c(-45, 45),
                            running_in_shiny = TRUE){

  data <- isolate(data)

  # Check if the data is valid
  if((dim(data)[2] != 2) | ("name" %in% names(data) == FALSE) | ("value" %in% names(data) == FALSE)){
    stop("The data must be made up of two columns, 'name' and 'value'")
  }

  # check if the "value" column is numeric
  if(class(data$value) != 'numeric' & class(data$value) != 'integer'){
    stop("The 'value' column must be numeric or integer.")
  }

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
                        "shape: 'circle',width: 600,height: 500,
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
