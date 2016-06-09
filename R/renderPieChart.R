renderPieChart <- function(div_id,
                           data,
                           radius = "50%",
                           center_x = "50%", center_y = "50%",
                           envir,
                           running_in_shiny = TRUE){

  part_1 <- paste("var " ,
                  div_id,
                  " = echarts.init(document.getElementById('",
                  div_id,
                  "'));",
                  sep="")

  part_2 <- paste("option_", div_id, " = {tooltip : {trigger: 'item',formatter: '{b} : {c} ({d}%)'}, series : [{type: 'pie', radius:'",
                  radius, "', center :['",
                  center_x, "','",
                  center_y, "'],",
                  sep="")

  names(data) <- c("name", "value")
  data <- as.character(jsonlite::toJSON(data))
  data <- gsub("\"", "\'", data)
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
    eval(parse(text = to_eval), envir = envir)
  } else {
    cat(to_eval)
  }

}


