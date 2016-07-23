library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts Word Cloud extension javascript library in advance
  loadEChartsLibrary(),


  h2("Diverse 'Shape' Options in Word Cloud"),

  fluidRow(
    column(4,
           strong("circle"),
           tags$div(id="test_1", style="width:100%;height:500px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),

    column(4,
           strong("diamond"),
           tags$div(id="test_2", style="width:100%;height:500px;"),
           deliverChart(div_id = "test_2")
           ),

    column(4,
           strong("triangle"),
           tags$div(id="test_3", style="width:100%;height:500px;"),
           deliverChart(div_id = "test_3")
    )
  ),

  fluidRow(
    column(4,
           strong("pentagon"),
           tags$div(id="test_4", style="width:100%;height:500px;"),
           deliverChart(div_id = "test_4")
    ),

    column(4,
           strong("triangle-forward"),
           tags$div(id="test_5", style="width:100%;height:500px;"),
           deliverChart(div_id = "test_5")
    ),

    column(4,
           strong("star"),
           tags$div(id="test_6", style="width:100%;height:500px;"),
           deliverChart(div_id = "test_6")
    )
  )



)
)
