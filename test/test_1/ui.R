library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(
  tags$script(src="echarts.js"),
  

  
  tags$div(id="Weekly_Total_1", style="width: '100%';height:300px;"),
  tags$script(src="test.js")
  # uiOutput("test")

  # placeholder.PieChart(div_id = "test", width = "100%", height = "300px"),
  # runPieChart(div_id = "test")

)
)
