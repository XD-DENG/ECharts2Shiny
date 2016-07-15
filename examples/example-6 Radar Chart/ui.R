library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme("shine"),


  # Compare normal line chart and stack line chart
  fluidRow(

    column(6,
           tags$div(id="test_radar_1", style="height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_radar_1")  # Deliver the plotting
           ),

    column(6,
           tags$div(id="test_radar_2", style="height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_radar_2")  # Deliver the plotting
    )


  )


)
)
