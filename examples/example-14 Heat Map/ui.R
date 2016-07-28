library(shiny)
library(ECharts2Shiny)

shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  fluidRow(
    column(4,
           h4("To Give A Matrix without Row Names or Column Names", align = "center"),
           tags$div(id="test_1", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_1")
           ),

    column(4,
           h4("To Give A Matrix with Row Names & Column Names", align = "center"),
           tags$div(id="test_2", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_2")
           ),

    column(4,
           h4("Deal with Missing Values in Data Input", align = "center"),
           tags$div(id="test_3", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_3")
    )
  )




  )
)

