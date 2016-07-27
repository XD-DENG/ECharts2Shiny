library(shiny)
library(ECharts2Shiny)

dat_1 <- volcano

dat_2 <- volcano
row.names(dat_2) <- 1:dim(dat_2)[1]
colnames(dat_2) <- 1:dim(dat_2)[2]

shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts
  renderHeatMap(div_id = "test_1",
                 data = dat_1)

  renderHeatMap(div_id = "test_2", theme = "macarons",
                data = dat_2)

  }
)
