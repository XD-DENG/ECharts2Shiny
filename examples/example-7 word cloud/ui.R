library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadWordcloudExtension(),

  h2("Population Ranking Top 10"),
  "Data Source: http://www.infoplease.com/world/statistics/most-populous-countries.html",
  tags$div(id="test", style="width:'80%';height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
  deliverChart(div_id = "test")  # Deliver the plotting


)
)
