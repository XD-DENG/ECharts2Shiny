library(shiny)
library(ECharts2Shiny)


shinyUI(fluidPage(
  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  h2("Adding Hyperlinks to Your Interactive Charts"),

  wellPanel(
    p("The 'hyperlinks' feature is only supported in pie chart, bar chart, and word cloud for this feature."),
    p("Please note, if hyperlinks are added into your charts, the fonts in the pop-up window will be in skyblue color and italic style, like", 
      em(span("hyperlinks", style = "color:skyblue")), 
      ". Then Users can click on the element to be redirected to the URL specified.")
    ),

  fluidRow(
    column(4,
           tags$div(id="test_1", style="width:100%;height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
           ),
    
    column(4,
           tags$div(id="test_2", style="width:100%;height:300px;"),
           deliverChart(div_id = "test_2")
           ),
    
    column(4,
           tags$div(id="test_3", style="width:80%;height:250px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_3")  # Deliver the plotting
    )
  )




)
)
