library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadWordcloudExtension(),

  h2("Population Ranking Top 10"),
  "Data Source: http://www.infoplease.com/world/statistics/most-populous-countries.html",
  fluidRow(
    column(6,
           tags$div(id="test_1", style="width:80%;height:250px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),

    column(6,
           tags$div(id="test_2", style="width:80%;height:250px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_2")  # Deliver the plotting
    )
  )



)
)
