\name{deliverChart}
\alias{deliverChart}

\title{
Deliver the Chart in the UI Component of Shiny Applications
}
\description{
This function helps deliver the charts plotted by ECharts into Shiny applications.
}
\usage{
deliverChart(div_id, running_in_shiny = TRUE)
}

\arguments{
  \item{div_id}{
    The id of the div which you need to specify first with tags$div() function of Shiny.
}
  \item{running_in_shiny}{
      If we're actually running this in a Shiny library, or we're simply doing testing. Default valus is "TRUE". If "FALSE", the function will print what it's supposed to evaluate.
}
}
\details{
  This will help us deliver the interactive charts. At the back-end, everything is donw by Javascript.
}

\author{
  Xiaodong DENG

  (ECharts library is authored by Baidu team)
}

\note{
  Users need to state the division for the chart first, with tags$div() function of Shiny packages. Please note that the division id must keep unique (duplicated division id will cause error).
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
    renderBarChart(div_id = "test", grid_left = '1\%', direction = "vertical", data = dat)
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
