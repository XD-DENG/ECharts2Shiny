
#####################################################
# To Use Reactive Data & Respond to the Change in Reactive Data
#####################################################

# In this example,
# we use the data from reactive() function
# This is very essential as sometimes we can only use reactive() function to prepare data within Shiny application.

# In this example you will find two totally the same charts. They're generated with the same data source.

# the only different is that the 2nd one can respond to the change in the reactive data, while the 1st chart can NOT.
# This is implemented together with observeEvent() function.


library(shiny)
library(ECharts2Shiny)


shinyServer(function(input, output) {

  # A reactive data.
  # it will change according to the change in "input$select"

  dat <- reactive({
    dat <- read.csv("data_for_pie_chart.csv", stringsAsFactors = FALSE, header = FALSE)
    dat <- dat[, 1]
    dat[dat %in% unique(dat)[1:input$select]] # select two or three categories to display
  })


  # Call functions from ECharts2Shiny to render charts

  # 1nd Chart: use reactive data, BUt can NOT respond to the change in reactive data
  renderPieChart(div_id = "test_1",
                 data = dat(),
                 radius = "70%",center_x = "50%", center_y = "50%")

  # 2nd Chart: use reactive data, AND CAN respond to the change in reactive data
  observeEvent(dat(),
               {
                 renderPieChart(div_id = "test_2",
                                data = dat(),
                                radius = "70%",center_x = "50%", center_y = "50%")
               })


})
