library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  h2("Scatter Plots with Diverse 'point.type'"),
  wellPanel(
    p("Valid values for 'point.type' in scatter plots includ 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow'.")
  ),
  # Compare normal line chart and stack line chart

     tags$div(id="test_scatter", style="width:90%;height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
     deliverChart(div_id = "test_scatter")  # Deliver the plotting




)
)
