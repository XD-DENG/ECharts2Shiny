renderPieChart <- function(div_id,
                           data,
                           name,
                           radius, 
                           center_x, center_y){
  
  part_1 <- paste("var " , 
                  div_id, 
                  " = echarts.init(document.getElementById('",
                  div_id, 
                  "));",
                  sep="")
                  
  part_2 <- paste("option_", div_id, " = {tooltip : {trigger: 'item',formatter: \"{a} <br/>{b} : {c} ({d}%)\"}, series : [{name: '",
                  name, "', type: 'pie', radius:'",
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
 
  final <- paste(part_1, part_2, part_3, part_4,
                 sep="")
  
  print(final)
  
  eval(parse(text = paste("tags$script(",
                          final,
                          ")",
                          sep=""))
  )
}


test_data = data.frame(a=c("A", "B", "C"),
                       b=c(1,2,3))
renderPieChart("Weekly_Toal", 
               test_data,
               "A Plot for Testing",
               "50%",
               "45%", "65%")
