library(shiny)
library(ECharts2Shiny)


shinyServer(function(input, output) {

  # A reactive data
  dat_0 <- reactive({
    dat <- read.csv("data_for_pie_chart.csv")

    columns_to_show<- sort(sample(names(dat), size = input$num))

    dat <- dat[, columns_to_show]
  })

  # Call functions from ECharts2Shiny to render charts
  # NOTE: we MUST use isolate() to create a non-reactive scope of our target data,
  # Otherwise we will encounter error regarding "Operation not allowed without an active reactive context."
  renderPieChart(div_id = "test",
                 data = dat_0(), 
                 radius = "70%",center_x = "50%", center_y = "50%")

  output$test_1 <- renderText({
    print(dim(dat_0()))
    dim(dat_0())[2]
  })


  observeEvent(dat_0(), {
    print("data_changed")
    renderPieChart(div_id = "test",
                   data = dat_0(), # Please note that we need to use isolate() here
                   radius = "70%",center_x = "50%", center_y = "50%")
  })


})
