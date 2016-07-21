library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

dat <- data.frame(x = iris$Sepal.Length,
                  y = iris$Sepal.Width,
                  group = iris$Species)



shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Scatter plot

  renderScatter("test_scatter_1", data = dat,
                theme = "shine")

  renderScatter("test_scatter_2", data = dat, auto.scale = FALSE, point.size = 20,
                theme = "shine")

  })
