library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

dat <- data.frame(Type.A = c(4300, 10000, 25000, 35000, 50000),
                  Type.B = c(5000, 14000, 28000, 31000, 42000),
                  Type.C = c(4000, 2000, 9000, 29000, 35000))
row.names(dat) <- c("Feture 1", "Feature 2", "Feature 3", "Feature 4", "Feature 5")



shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Radar Chart
  renderRadarChart("test_radar_1", data = dat,
                   theme = "shine")

  renderRadarChart("test_radar_2", data = dat, shape = "circle", line.width = 5,
                   theme = "shine")


  })
