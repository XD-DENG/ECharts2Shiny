test_data = data.frame(a=c("A", "B", "C"),
                       b=c(1,2,3))
renderPieChart("Weekly_Total",
               test_data,
               "Sales Count",
               "50%",
               "50%", "50%",
               running_in_shiny = FALSE)


runPieChart("Test", running_in_shiny = FALSE)


placeholder.PieChart("Test", "100%", "300px",
                     running_in_shiny = FALSE)
