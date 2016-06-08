renderPieChart <- function(div_id,
                           data,
                           item_name = "-",
                           radius, 
                           center_x, center_y,
                           running_in_shiny = TRUE){
  
  part_1 <- paste("var " , 
                  div_id, 
                  " = echarts.init(document.getElementById('",
                  div_id, 
                  "'));",
                  sep="")
                  
  part_2 <- paste("option_", div_id, " = {tooltip : {trigger: 'item',formatter: \"{a} <br/>{b} : {c} ({d}%)\"}, series : [{name: '",
                  item_name, "', type: 'pie', radius:'",
                  radius, "', center :['",
                  center_x, "','",
                  center_y, "'],",
                  sep="")
  
  names(data) <- c("name", "value")
  part_3 <- paste("data:",
                  jsonlite::toJSON(data),
                  ", itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]};",
                  sep="")
  
  part_4 <- paste(div_id,
                  ".setOption(option_",
                  div_id,
                  ");",
                  sep="")
 
  to_eval <- paste(part_1, part_2, part_3, part_4,
                 sep="")
  
  if(running_in_shiny == TRUE){
    eval(parse(text = paste("tags$script(",
                            to_eval,
                            ")",
                            sep=""))
    )
  } else {
    cat(to_eval)
  }
  
}


test_data = data.frame(a=c("A", "B", "C"),
                       b=c(1,2,3))
renderPieChart("Weekly_Toal", 
               test_data,
               "Sales Count",
               "50%",
               "50%", "50%",
               running_in_shiny = FALSE)
