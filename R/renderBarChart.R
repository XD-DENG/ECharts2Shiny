renderBarChart <- function(div_id,
                           data,
                           direction = "horizontal",
                           grid_top = "3%", grip_bottom = "10%",
                           grid_left = "3%", grip_right = "4%",
                           running_in_shiny = TRUE){

  if(direction == "horizontal"){
    direction_vector = c("xAxis", "yAxis")
  }else{
    if(direction == "vertical"){
      direction_vector = c("yAxis", "xAxis")
    }else{
      stop("The 'direction' argument can be either 'horizontal' or 'vertical'")
    }

  }

  names(data) <- c("name", "value")
  yaxis_name <- data$name
  data <- as.character(jsonlite::toJSON(data))
  data <- gsub("\"", "\'", data)

  part_1 <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "'));",
                  sep="")

  part_2 <- paste("option_", div_id,
                  " = {tooltip : {trigger:'axis', axisPointer:{type:'shadow'}}, toolbox:{feature:{saveAsImage:{}}}, ",
                  direction_vector[1],
                  ":[{type:'value'}], ",
                  direction_vector[2],
                  ":[{type:'category', axisTick:{show:false}, data:[",
                  paste(sapply(yaxis_name, function(x){paste("'", x, "'", sep="")}), collapse = ","),
                  "]}],series : [{type: 'bar', ",
                  "label:{normal:{show: true, position:'inside'}},",
                  sep="")


  part_3 <- paste("data:",
                  data,
                  "}]};",
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


