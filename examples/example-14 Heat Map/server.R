library(shiny)
library(ECharts2Shiny)


dat_1 <- volcano
row.names(dat_1) <- 1:dim(dat_1)[1]
colnames(dat_1) <- 1:dim(dat_1)[2]

# A sample data with NA values
dat_2 <- volcano
dat_2[10:15, 10:15] <- NA
row.names(dat_2) <- 1:dim(dat_2)[1]
colnames(dat_2) <- 1:dim(dat_2)[2]


shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts
  renderHeatMap(div_id = "test_1",
                 data = dat_1)

  renderHeatMap(div_id = "test_2",
                data = dat_2)

  }
)
