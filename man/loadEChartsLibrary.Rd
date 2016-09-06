\name{loadEChartsLibrary}
\alias{loadEChartsLibrary}

\title{
  Load the Javascript Library File of ECharts to the Shiny Application
}
\description{
  This function will help load the Javascript library file of ECharts to the current shiny project. This is mandatory before we can plot with ECharts in Shiny applications.
}
\usage{
loadEChartsLibrary()
}

\author{
  Xiaodong DENG

  (ECharts library is authored by Baidu team)
}



\examples{

if (interactive()) {
  library(shiny)
  library(ECharts2Shiny)

  # Prepare sample data for plotting --------------------------
  dat <- data.frame(c(1, 2, 3))
  names(dat) <- c("Type-A")
  row.names(dat) <- c("Time-1", "Time-2", "Time-3")

  # Server function -------------------------------------------
  server <- function(input, output) {
    # Call functions from ECharts2Shiny to render charts
    renderBarChart(div_id = "test", grid_left = '1\%', direction = "vertical",
                   data = dat)
  }

  # UI layout -------------------------------------------------
  ui <- fluidPage(
    # We MUST load the ECharts javascript library in advance
    loadEChartsLibrary(),

    tags$div(id="test", style="width:50\%;height:400px;"),
    deliverChart(div_id = "test")
  )

  # Run the application --------------------------------------
  shinyApp(ui = ui, server = server)
}

}

