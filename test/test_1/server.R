library(shiny)
library(ECharts2Shiny)

dat <- data.frame(a=c("A", "B", "C"),
                  b=c(1, 2, 3))

dat_line <- data.frame(c(1, 2, 3),
                  c(2, 4, 6),
                  c(3, 2, 7))

names(dat_line) <- c("Type-A", "Type-B", "Type-C")
row.names(dat_line) <- c("Time-1", "Time-2", "Time-3")


shinyServer(function(input, output) {

  # Call renderPieChart function to render charts
  renderPieChart(div_id = "test_1",
                 data = dat,
                 radius = "70%",center_x = "50%", center_y = "50%")

  renderPieChart(div_id = "test_2",
                 data = dat,
                 radius = "50%",center_x = "50%", center_y = "50%")

  renderBarChart(div_id = "test_3",
                 data = dat)

  renderBarChart(div_id = "test_4",
                 direction = "vertical",
                 data = dat)

  renderLineChart(div_id = "test_5",
                  data = dat_line)


  })
