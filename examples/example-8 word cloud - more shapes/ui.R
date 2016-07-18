library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts Word Cloud extension javascript library in advance
  loadWordcloudExtension(),

  h2("Diverse 'Shape' Options in Word Cloud"),

  fluidRow(
    column(4,
           tags$div(id="test_1", style="width:100%;height:500px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),

    column(4,
           tags$div(id="test_2", style="width:100%;height:500px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_2")  # Deliver the plotting
           ),

    column(4,
           tags$div(id="test_3", style="width:100%;height:500px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_3")  # Deliver the plotting
    )
  )



)
)
