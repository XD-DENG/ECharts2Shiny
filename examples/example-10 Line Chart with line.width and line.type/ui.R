library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(
  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  fluidRow(
    column(6,
           h3("Set 'line.width' and 'line.type' with Single Values", align = "center"),
           tags$div(id="test_1", style="width:100%;height:400px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),
    column(6,
           h3("Set 'line.width' and 'line. type ' with Vectors", align = "center"),
           tags$div(id="test_2", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_2")
           )
  )
)
)
