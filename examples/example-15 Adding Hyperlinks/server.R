library(shiny)
library(ECharts2Shiny)



# Prepare sample data for plotting ---------------------------------------

dat_1 <- data.frame(name=c("Google", "Bing", "Baidu"),
                    value=c(8, 5, 1))

dat_2 <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat_2) <- c("Type-A", "Type-B", "Type-C")
row.names(dat_2) <- c("Time-1", "Time-2", "Time-3", "Time-4")


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


  renderBarChart(div_id = "test_2", grid_left = '1%',
                 data = dat_2,
                 hyperlinks = c("http://me.seekingqed.com",
                                "https://google.com",
                                "https://github.com",
                                "http://www.bjfu.edu.cn"))

  renderBarChart(div_id = "test_3", theme = "vintage",
                 direction = "vertical", grid_left = "10%",
                 data = dat_2,
                 hyperlinks = c("http://me.seekingqed.com",
                                "https://google.com",
                                "https://github.com",
                                "http://www.bjfu.edu.cn"))

  renderWordcloud("test_4", data =sample_data_for_wordcloud,
                  grid_size = 10, sizeRange = c(20, 50),
                  hyperlinks = c(rep("http://me.seekingqed.com", 3), rep("https://github.com", 4)))


  })
