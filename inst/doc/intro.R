## ---- eval=FALSE---------------------------------------------------------
#  library(shiny)
#  library(ECharts2Shiny)
#  
#  shinyUI(fluidPage(
#    # We HAVE TO to load the ECharts javascript library in advance
#    loadEChartsLibrary(),
#    loadEChartsTheme('shine'),
#    loadEChartsTheme('vintage'),
#  
#    fluidRow(
#      column(6,
#             tags$div(id="test_1", style="width: '80%';height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
#             deliverChart(div_id = "test_1")  # Deliver the plotting
#             ),
#      column(6,
#             tags$div(id="test_2", style="width:80%;height:300px;"),
#             deliverChart(div_id = "test_2")
#             )
#    ),
#  
#    fluidRow(
#      column(6,
#             tags$div(id="test_3", style="width:80%;height:300px;"),
#             deliverChart(div_id = "test_3")
#             ),
#      column(6,
#             tags$div(id="test_4", style="width:80%;height:300px;"),
#             deliverChart(div_id = "test_4")
#             )
#    ),
#  
#    fluidRow(
#      column(6,
#             tags$div(id="test_5", style="width:100%;height:400px;"),
#             deliverChart(div_id = "test_5")
#      ),
#      column(6
#      )
#    )
#  )
#  )

## ---- eval=FALSE---------------------------------------------------------
#  library(shiny)
#  library(ECharts2Shiny)
#  
#  # Prepare sample data for plotting ---------------------------------------
#  
#  dat_1 <- data.frame(matrix(c(3,2,8), 1,3))
#  names(dat_1) <- c("Type-A", "Type-B", "Type-C")
#  
#  
#  dat_2 <- data.frame(c(1, 2, 3, 1),
#                    c(2, 4, 6, 6),
#                    c(3, 2, 7, 5))
#  names(dat_2) <- c("Type-A", "Type-B", "Type-C")
#  row.names(dat_2) <- c("Time-1", "Time-2", "Time-3", "Time-4")
#  
#  shinyServer(function(input, output) {
#  
#    # Call functions from ECharts2Shiny to render charts
#    renderPieChart(div_id = "test_1",
#                   data = dat_1,
#                   radius = "70%",center_x = "50%", center_y = "50%")
#  
#    renderLineChart(div_id = "test_2", theme = "shine",
#                    data = dat_2)
#  
#    renderBarChart(div_id = "test_3", grid_left = '1%',
#                   data = dat_2)
#  
#    renderBarChart(div_id = "test_4", theme = "vintage",
#                   direction = "vertical", grid_left = "10%",
#                   data = dat_2)
#  
#    renderGauge(div_id = "test_5", gauge_name = "Finished Rate",
#                rate = 99.9)
#    })
#  

## ---- out.width = 800----------------------------------------------------
knitr::include_graphics("Capture.png")

## ---- eval=FALSE---------------------------------------------------------
#  tags$script(src="http://echarts.baidu.com/dist/echarts.min.js")

