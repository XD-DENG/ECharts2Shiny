library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

dat_1 <- data.frame(matrix(c(3,2,8), 1,3))
names(dat_1) <- c("Type-A", "Type-B", "Type-C")


dat_2 <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat_2) <- c("Type-A", "Type-B", "Type-C")
row.names(dat_2) <- c("Time-1", "Time-2", "Time-3", "Time-4")




shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Compare normal line chart and stack line chart
  renderLineChart(div_id = "test_1_1",
                  data = dat_2)
  
  renderLineChart(div_id = "test_1_2",
                  data = dat_2, stack_plot = TRUE)

  
  
  # Illustrate the options to keep or remove the legend and tool bars
  renderBarChart(div_id = "test_2_1",
                 direction = "vertical", grid_left = "10%",
                 data = dat_2)

  renderBarChart(div_id = "test_2_2",
                 direction = "vertical", grid_left = "10%",
                 data = dat_2, 
                 show.legend = FALSE, show.tools = FALSE)

  })
