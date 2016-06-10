library(ECharts2Shiny)

test_data = data.frame(a=c("A", "B", "C"),
                       b=c(1,2,3))

renderPieChart("Weekly_Total",
               test_data,
               "50%",
               "50%", "50%",
               running_in_shiny = FALSE)


runPieChart("Test", running_in_shiny = FALSE)
