library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

sample_data_for_wordcloud <- data.frame(name = sapply(1:100,
                                                      function(i){
                                                        paste(sample(letters, 6), collapse = "")
                                                        }),
                                        value = rnorm(100, mean = 100, sd=100))

shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Radar Chart
  renderWordcloud("test_1", data =sample_data_for_wordcloud,
                  grid_size = 1, sizeRange = c(5, 15), rotationRange = c(-90, 90))

  renderWordcloud("test_2", data =sample_data_for_wordcloud, shape = "diamond",
                  grid_size = 1, sizeRange = c(5, 15), rotationRange = c(-90, 90))

  renderWordcloud("test_3", data =sample_data_for_wordcloud, shape = "triangle",
                  grid_size = 1, sizeRange = c(5, 15), rotationRange = c(-90, 90))

  renderWordcloud("test_4", data =sample_data_for_wordcloud, shape = "pentagon",
                  grid_size = 1, sizeRange = c(5, 15), rotationRange = c(-90, 90))

  renderWordcloud("test_5", data =sample_data_for_wordcloud, shape = "triangle-forward",
                  grid_size = 1, sizeRange = c(5, 15), rotationRange = c(-90, 90))

  renderWordcloud("test_6", data =sample_data_for_wordcloud, shape = "star",
                  grid_size = 1, sizeRange = c(5, 15), rotationRange = c(-90, 90))



  })
