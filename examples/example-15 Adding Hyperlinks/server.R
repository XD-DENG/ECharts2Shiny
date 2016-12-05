library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

dat_1 <- data.frame(name=c("Google", "Bing", "Baidu"),
                    value=c(8, 5, 1))

dat_2 <- data.frame(c(17125200, 9596961, 9833517))
names(dat_2) <- "Area_Km_Square"
row.names(dat_2) <- c("Russia", "China", "United States")


sample_data_for_wordcloud <- data.frame(name = c("Asia", "Africa", "North America", "South America",
                                                 "Antarctica", "Europe", "Australia"),
                                        value = c(44391162, 30244049, 24247039, 17821029, 14245000,
                                                  10354636, 7686884))






shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts
  renderPieChart(div_id = "test_1",
                 data = dat_1,
                 radius = "70%",center_x = "50%", center_y = "50%",
                 hyperlinks = c("https://google.com",
                                "https://bing.com",
                                "https://www.baidu.com"))


  renderBarChart(div_id = "test_2",
                 direction = "vertical", grid_left = "10%",
                 data = dat_2,
                 hyperlinks = c("https://en.wikipedia.org/wiki/Russia",
                                "https://en.wikipedia.org/wiki/China",
                                "https://en.wikipedia.org/wiki/United_States"))

  renderWordcloud("test_3", data =sample_data_for_wordcloud,
                  grid_size = 10, sizeRange = c(20, 50),
                  hyperlinks = c("https://en.wikipedia.org/wiki/Asia",
                                 "https://en.wikipedia.org/wiki/Africa",
                                 "https://en.wikipedia.org/wiki/North_America",
                                 "https://en.wikipedia.org/wiki/South_America",
                                 "https://en.wikipedia.org/wiki/Antarctica",
                                 "https://en.wikipedia.org/wiki/Europe",
                                 "https://en.wikipedia.org/wiki/Australia"))


  })
