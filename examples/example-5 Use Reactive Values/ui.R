
#####################################################
# To Use Reactive Data & Respond to the Change in Reactive Data
#####################################################


library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  h2("To Use Reactive Data & Respond to the Change in Reactive Data"),

  selectInput("select", label = h3("Select box"),
              choices = list("Include A, B, and C" = 3, "Include A and B" = 2),
              selected = 3),

  fluidRow(
    column(6,
           wellPanel("Use reactive data, but can't respond to the change in reactive data"),

           tags$div(id="test_1", style="width:100%; height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),

    column(6,
           wellPanel("Use reactive data, and CAN respond to the change in reactive data"),

           tags$div(id="test_2", style="width:100%; height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_2")  # Deliver the plotting
           )
)
)
)
