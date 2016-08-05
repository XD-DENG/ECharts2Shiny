\name{renderRadarChart}
\alias{renderRadarChart}
\title{
Render the Radar Chart Plotted by ECharts into Shiny Application
}
\description{
renderRadarChart() function helps render the Radar chart into Shiny application.
}
\usage{
renderRadarChart(div_id, data, theme = "default",
                  shape = "default", line.width = 2,
                  show.legend = TRUE, show.tools = TRUE,
                  font.size.legend = 12,
                  animation = TRUE,
                  running_in_shiny = TRUE)
}
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
  The data used for the plotting. It should be a data.frame. For radar chart, the data must have row names and column names specified.
}
  \item{theme}{
Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{shape}{
The shape of the radar chart. Valid values include "default" and "circle".
}
  \item{line.width}{
The width of the lines in the radar chart.
}
  \item{show.legend}{
If display the legends. The default value is TRUE.
}
  \item{show.tools}{
If display the tool bar. The default value is TRUE.
}
  \item{font.size.legend}{
The font size of legend bar. The default value is 12.
}
  \item{animation}{
Whether display the chart with animation. The default value is TRUE.
}
  \item{running_in_shiny}{
      If we're actually running this in a Shiny library, or we're simply doing testing. Default valus is "TRUE". If "FALSE", the function will print what it's supposed to evaluate.
}
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


  dat <- data.frame(Type.A = c(4300, 10000, 25000, 35000, 50000),
                    Type.B = c(5000, 14000, 28000, 31000, 42000),
                    Type.C = c(4000, 2000, 9000, 29000, 35000))
  row.names(dat) <- c("Feture 1", "Feature 2", "Feature 3", "Feature 4", "Feature 5")


  # Server function -------------------------------------------
  server <- function(input, output) {
    renderRadarChart(div_id = "test",
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

