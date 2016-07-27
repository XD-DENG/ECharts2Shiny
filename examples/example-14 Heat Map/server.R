library(shiny)
library(ECharts2Shiny)

shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts
  renderHeatMap(div_id = "test",
                 data = volcano)
  })
