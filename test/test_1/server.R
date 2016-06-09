library(shiny)
library(ECharts2Shiny)

dat <- data.frame(a=c("A", "B", "C"),
                  b=c(1, 2, 3))


shinyServer(function(input, output) {
  shiny_envir <- environment()
  renderPieChart(div_id = "Weekly_Total_1", 
                 data = dat, 
                 envir = shiny_envir,
                 radius = "50%",center_x = "50%", center_y = "50%")
  }


)