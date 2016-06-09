library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(
  
  # We HAVE TO to load the ECharts javascript library in advance
  tags$script(src="echarts.js"),
  
  fluidRow(
    column(6,
           tags$div(id="test_1", style="width: '50%';height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           runPieChart(div_id = "test_1")  # Deliver the plotting
           ),
    column(6,
           tags$div(id="test_2", style="width: '80%';height:200px;"),  # Specify the div for the chart. Can also be considered as a space holder
           runPieChart(div_id = "test_2")  # Deliver the plotting
           )
  )

)
)
