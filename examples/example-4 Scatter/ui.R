library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme("shine"),

  h2("Scatter Plots"),
  wellPanel("Please click on 'setosa' or 'virginica' in the legend bar in both charts, in order to check the difference."),
  # Compare normal line chart and stack line chart
  fluidRow(
    column(6,
           h3("auto.scale == TRUE (default setting)"),
           tags$div(id="test_scatter_1", style="width:90%;height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_scatter_1")  # Deliver the plotting
           ),
    column(6,
           h3("auto.scale == FALSE"),
           tags$div(id="test_scatter_2", style="width:90%;height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_scatter_2")  # Deliver the plotting
           )
  )



)
)
