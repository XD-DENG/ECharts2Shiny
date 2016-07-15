library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

sample_data_for_wordcloud <- data.frame(name = c("China", "India", "United States", "Indonesia", "Brazil",
                                                 "Pakistan", "Nigeria", "Bangladesh", "Russia", "Japan"),
                                        value = c(1367485388, 1251695584, 321368864, 255993674, 204259812,
                                                  199085847, 181562056, 168957745, 142423773, 126919659))

shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Radar Chart
  renderWordcloud("test_1", data =sample_data_for_wordcloud,
                  grid_size = 10, sizeRange = c(20, 50))

  renderWordcloud("test_2", data =sample_data_for_wordcloud,
                  grid_size = 2, sizeRange = c(10, 20), rotationRange = c(-90, 90))



  })
