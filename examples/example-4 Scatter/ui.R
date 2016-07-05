library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme("shine"),


  # Compare normal line chart and stack line chart
  fluidRow(

     tags$div(id="test_scatter", style="width:'80%';height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
     deliverChart(div_id = "test_scatter")  # Deliver the plotting

  )


)
)
