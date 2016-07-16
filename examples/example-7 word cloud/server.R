library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

sample_data_for_wordcloud <- data.frame(name = c("Asia", "Africa", "North America", "South America",
                                                 "Antarctica", "Europe", "Australia"),
                                        value = c(44391162, 30244049, 24247039, 17821029, 14245000,
                                                  10354636, 7686884))

shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Radar Chart
  renderWordcloud("test_1", data =sample_data_for_wordcloud,
                  grid_size = 10, sizeRange = c(20, 50))

  renderWordcloud("test_2", data =sample_data_for_wordcloud,
                  grid_size = 2, sizeRange = c(10, 20), rotationRange = c(-90, 90))



  })
