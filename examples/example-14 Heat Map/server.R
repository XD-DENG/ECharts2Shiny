library(shiny)
library(ECharts2Shiny)

dat_1 <- volcano

# A sample data with row names and column names
dat_2 <- volcano
row.names(dat_2) <- 1:dim(dat_2)[1]
colnames(dat_2) <- 1:dim(dat_2)[2]

# A sample data with NA values
dat_3 <- volcano
dat_3[10:15, 10:15] <- NA


shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts
  renderHeatMap(div_id = "test_1",
                 data = dat_1)

  renderHeatMap(div_id = "test_2",
                data = dat_2)

  renderHeatMap(div_id = "test_3",
                data = dat_3)

  }
)
