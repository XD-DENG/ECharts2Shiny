library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(
  tags$script(src="echarts.js"),
  

  
  tags$div(id="Weekly_Total_1", style="width: '50%';height:300px;"),

  placeholder.PieChart(div_id = "Weekly_Total_1", width = "50%", height = "300px"),
  runPieChart(div_id = "Weekly_Total_1")

)
)
