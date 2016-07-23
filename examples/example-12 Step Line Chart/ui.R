library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(
  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  h2("Step Line Chart"),

  fluidRow(
    column(4,
           h4("step = 'start'", align = "center"),
           tags$div(id="test_1", style="width:100%;height:400px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),
    column(4,
           h4("step = 'middle'", align = "center"),
           tags$div(id="test_2", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_2")
           ),
    column(3,
           h4("step = 'end'", align = "center"),
           tags$div(id="test_3", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_3")
    )
  )
)
)
