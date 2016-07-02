

# Pie Chart ---------------------------------------------------------------


renderPieChart <- function(div_id,
                           data, theme = "default",
                           radius = "50%",
                           center_x = "50%", center_y = "50%",
                           running_in_shiny = TRUE){

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

  part_1 <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",
                  sep="")

  part_2 <- paste("option_", div_id, " = {tooltip : {trigger: 'item',formatter: '{b} : {c} ({d}%)'}, toolbox:{feature:{saveAsImage:{}}}, ",
                  "legend:{orient: 'vertical', left: 'left', data:",
                  legend_data,  "},",
                  "series : [{type: 'pie', radius:'", radius, "', center :['", center_x, "','", center_y, "'],",
                  sep="")

  part_3 <- paste("data:",
                  data,
                  ", itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]};",
                  sep="")

  part_4 <- paste(div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
                  sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({fluidPage(tags$script(\"",
                   part_1, part_2, part_3, part_4,
                   "\"))})",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}





# Bar Chart ---------------------------------------------------------------


renderBarChart <- function(div_id,
                           data, theme = "default",
                           direction = "horizontal",
                           grid_left = "3%", grid_right = "4%", grid_top = "16%", grid_bottom = "3%",
                           running_in_shiny = TRUE){

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
    temp <- paste("{name:'", names(data)[i], "', type:'bar', data:[",
                  paste(data[, i], collapse = ", "),
                  "]}",
                  sep=""
    )
    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")
  series_data <- paste("[", series_data, "]", sep="")



  part_1 <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",
                  sep="")

  part_2 <- paste("option_", div_id,
                  " = {tooltip : {trigger:'axis', axisPointer:{type:'shadow'}}, toolbox:{feature:{saveAsImage:{}}}, legend:{data:",
                  legend_name, "}, grid: {left:'", grid_left, "', right:'", grid_right, "', top:'", grid_top, "', bottom:'", grid_bottom, "', containLabel: true},",
                  direction_vector[1],
                  ":[{type:'value'}], ",
                  direction_vector[2],
                  ":[{type:'category', axisTick:{show:false}, data:",
                  xaxis_name,
                  "}],series :",
                  series_data,
                  "};",
                  sep="")

  part_3 <- paste(div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
                  sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({fluidPage(tags$script(\"",
                   part_1, part_2, part_3,
                   "\"))})",
                 sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}





# Line Chart --------------------------------------------------------------


renderLineChart <- function(div_id,
                            data, theme = "default",
                            running_in_shiny = TRUE){


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

  part_1 <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",
                  sep="")

  series_data <- rep("", dim(data)[2])
  for(i in 1:length(series_data)){
    temp <- paste("{name:'", names(data)[i], "', type:'line', data:[",
                  paste(data[, i], collapse = ", "),
                  "]}",
                  sep=""
    )
    series_data[i] <- temp
  }
  series_data <- paste(series_data, collapse = ", ")

  part_2 <- paste("option_", div_id, " = {tooltip : {trigger: 'axis'}, toolbox:{feature:{saveAsImage:{}}}, ",
                  "legend:{data:",
                  legend_name,
                  "}, yAxis: { type: 'value'}, xAxis:{type:'category', boundaryGap: false, data:",
                  xaxis_name,
                  "}, series:[",
                  series_data,
                  "]};",
                  sep="")

  part_3 <- paste(div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
                  sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({fluidPage(tags$script(\"",
                   part_1, part_2, part_3,
                   "\"))})",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}




# Gauge -------------------------------------------------------------------

renderGauge <- function(div_id, theme = "default",
                        gauge_name, rate,
                        running_in_shiny = TRUE){


  # Check the value for theme
  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  theme_placeholder <- ifelse(theme == "default",
                              "",
                              paste(", '",theme,  "'", sep=""))

  series_data <- paste("[{name:'",gauge_name, "',value:", rate, "}]", sep="")


  part_1 <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "')",
                  theme_placeholder,
                  ");",
                  sep="")

  part_2 <- paste("option_", div_id, "={tooltip : {formatter: '{b} : {c}%'},toolbox: {feature: {saveAsImage: {}}},",
                  "series:[{name:'", gauge_name, "', type:'gauge', detail: {formatter:'{value}%'},data:",
                  series_data,
                  "}]};",
                  sep="")

  part_3 <- paste(div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
                  sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({fluidPage(tags$script(\"",
                   part_1, part_2, part_3,
                   "\"))})",
                   sep="")


  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }

}

