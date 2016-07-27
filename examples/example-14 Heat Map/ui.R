library(shiny)
library(ECharts2Shiny)

shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  tags$div(id="test", style="width:100%;height:500px;"),
  deliverChart(div_id = "test")

  )
)

