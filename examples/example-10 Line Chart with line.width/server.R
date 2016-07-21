library(shiny)
library(ECharts2Shiny)


# Prepare sample data for plotting ---------------------------------------


dat <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat) <- c("Type-A", "Type-B", "Type-C")
row.names(dat) <- c("Time-1", "Time-2", "Time-3", "Time-4")




shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # set line.width with a single value
  renderLineChart(div_id = "test_1",
                  data = dat,
                  line.width = 8)

  # set line.width with a vector whose length is the same as the number of categories in the data
  renderLineChart(div_id = "test_2",
                  data = dat,
                  line.width = c(2, 6, 12))


  })
