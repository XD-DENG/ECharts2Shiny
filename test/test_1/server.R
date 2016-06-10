library(shiny)
library(ECharts2Shiny)

dat <- data.frame(a=c("A", "B", "C"),
                  b=c(1, 2, 3))


shinyServer(function(input, output) {
  
  
  # Call renderPieChart function to render charts
  renderPieChart(div_id = "test_1", 
                 data = dat, 
                 envir = environment(),
                 radius = "70%",center_x = "50%", center_y = "50%")


  renderPieChart(div_id = "test_2", 
                 data = dat, 
                 envir = environment(),
                 radius = "50%",center_x = "50%", center_y = "50%")
  
  
  })