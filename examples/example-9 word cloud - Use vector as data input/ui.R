library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts Word Cloud extension javascript library in advance
  loadEChartsLibrary(),


  h2("Use Vector as Data Input for Word Cloud"),

  tags$div(id="test", style="width:80%;height:250px;"),  # Specify the div for the chart. Can also be considered as a space holder
  deliverChart(div_id = "test")  # Deliver the plotting
)
)
