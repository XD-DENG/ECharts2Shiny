\name{renderHeatMap}
\alias{renderHeatMap}
\title{
Render Heat Map Plotted by ECharts into Shiny Applications
}
\description{
renderHeatMap() function helps render heat map charts into Shiny applications.
}
\usage{
renderHeatMap(div_id, data,
              theme = "default",
              show.tools = TRUE,
              running_in_shiny = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
The data input must be a matrix containing numeric or integer values. Users can choose to have or not have row names or columns names. If row names or column names are assigned to the matrix, the names will be the axis label. Otherwise, the axis label will be empty.
}
  \item{theme}{
Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{show.tools}{
If display the tool bar. The default value is TRUE.
}
  \item{running_in_shiny}{
      If we're actually running this in a Shiny library, or we're simply doing testing. Default valus is "TRUE". If "FALSE", the function will print what it's supposed to evaluate.
}
}
\references{
https://github.com/ecomfe/echarts-wordcloud
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


  # Server function -------------------------------------------
  server <- function(input, output) {
    renderHeatMap(div_id = "test",
                  data = volcano)
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

