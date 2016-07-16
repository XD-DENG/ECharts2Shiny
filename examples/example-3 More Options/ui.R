library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),


  # Compare normal line chart and stack line chart
  fluidRow(
    h3("Normal Line Chart vs. Stack Line Chart"),
    column(6,
           tags$div(id="test_1_1", style="width:80%;height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1_1")  # Deliver the plotting
    ),
    column(6,
           tags$div(id="test_1_2", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_1_2")
    )
  ),

  hr(),


  # Illustrate the options to keep or remove the legend and tool bars
  fluidRow(
    h3("Choose to keep legends and tool bar, or to remove them"),
    column(6,
           tags$div(id="test_2_1", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_2_1")
           ),
    column(6,
           tags$div(id="test_2_2", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_2_2")
           )
  )
)
)
