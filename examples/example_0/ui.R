library(shiny)
library(ECharts2Shiny)

shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  tags$div(id="test", style="width:80%;height:300px;"),
  deliverChart(div_id = "test")
  )
)

