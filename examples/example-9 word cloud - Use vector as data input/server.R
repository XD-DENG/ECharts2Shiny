library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------


sample_data_for_wordcloud <- c(rep("R", 100),
                               rep("Python", 100),
                               rep("SAS", 90),
                               rep("VBA", 50))

shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts

  # Radar Chart
  renderWordcloud("test", data =sample_data_for_wordcloud,
                  grid_size = 10, sizeRange = c(20, 50))

  })
