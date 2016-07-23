library(shiny)
library(ECharts2Shiny)


# Prepare sample data for plotting ---------------------------------------


dat <- data.frame(c(1, 2, 3, 4),
                  c(5, 7, 9, 7),
                  c(12, 11, 16, 14))
names(dat) <- c("Type-A", "Type-B", "Type-C")
row.names(dat) <- c("Time-1", "Time-2", "Time-3", "Time-4")




shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  renderLineChart(div_id = "test_1",
                  data = dat,
                  step = "start",
                  show.legend = FALSE)

  renderLineChart(div_id = "test_2",
                  data = dat,
                  step = "middle",
                  show.legend = FALSE)

  renderLineChart(div_id = "test_3",
                  data = dat,
                  step = "end",
                  show.legend = FALSE)




  })
