library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance

  loadEChartsLibrary(),

  fluidRow(
    column(6,
           tags$div(id="test_1", style="width: '50%';height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),
    column(6,
           tags$div(id="test_2", style="width: '80%';height:200px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_2")  # Deliver the plotting
           )
  ),

  fluidRow(
    column(6,
           tags$div(id="test_3", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_3")
           ),
    column(6,
           tags$div(id="test_4", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_4")
           )
  )




)
)
