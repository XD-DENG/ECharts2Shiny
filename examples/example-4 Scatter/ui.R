library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme("shine"),

  h2("Scatter Plots"),
  wellPanel(
    p("[1] Please click on 'setosa' or 'virginica' in the legend bar in both charts, in order to check the difference derived by argument 'auto.scale'."),
    p("[2] The size of points in scatter plots can be set with argument 'point.size', just like what we did in the right panel.")),
  # Compare normal line chart and stack line chart
  fluidRow(
    column(6,
           h3("auto.scale = TRUE & default point.size (10)"),
           tags$div(id="test_scatter_1", style="width:90%;height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_scatter_1")  # Deliver the plotting
           ),
    column(6,
           h3("auto.scale = FALSE & point.size = 20"),
           tags$div(id="test_scatter_2", style="width:90%;height:600px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_scatter_2")  # Deliver the plotting
           )
  )



)
)
