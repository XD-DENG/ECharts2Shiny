\name{renderLineChart}
\alias{renderLineChart}

\title{
Render the Line Chart Plotted by ECharts into Shiny Application
}
\description{
renderLineChart() function helps render the line chart into Shiny application.
}
\usage{
renderLineChart(div_id, data, theme = "default",
                line.width = 2, line.type = "solid",
                point.size = 5, point.type = "emptyCircle",
                stack_plot = FALSE, step = "null",
                show.legend = TRUE, show.tools = TRUE,
                font.size.legend= 12,
                font.size.axis.x = 12, font.size.axis.y = 12,
                rotate.axis.x = 0, rotate.axis.y = 0,
                show.slider.axis.x = FALSE, show.slider.axis.y = FALSE,
                animation = TRUE,
                running_in_shiny = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
  The data used for the plotting. It should be a data.frame. Each column of the data.frame is one category, and each row is one observation (like one timepoint).
}
  \item{theme}{
Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{line.width}{
This is to help set the width of the lines.

The value should be either numeric or integer. The default value is 2.

Its length should be either one or the same as the number of categories in the data (the number of columns in the data).
}
  \item{line.type}{
The type of the lines.

The value can be "solid", "dashed", or "dotted". The default value is "solid".

Its length should be either one or the same as the number of categories in the data (the number of columns in the data).
}
  \item{point.size}{
This argument helps set the size of points in the scatter plots.

The value should be either numeric or integer. The default value is 5.

Its length should be either one or the same as the number of categories in the data (the number of columns in the data).
}
  \item{point.type}{
The shape of the points in scatter plots.

Valid values include 'emptyCircle', 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow'. The default value is 'emptyCircle'.

Its length should be either one or the same as the number of categories in the data (the number of columns in the data).
}
  \item{stack_plot}{
Whether do stack line chart. The default value is FALSE.
}
  \item{step}{
This argument helps plot step line charts. The default value is "null", i.e., non-step line chart.

If users want step line chart, they can choose "start", "middle", or "end" to determine the turning point positions in the step line charts.
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
  \item{font.size.axis.x}{
The font size of the labels on X axis. The default value is 12.
}
  \item{font.size.axis.y}{
The font size of the labels on Y axis. The default value is 12.
}
  \item{rotate.axis.x}{
The rotation degree of labels on X axis. The default value is 0.
}
  \item{rotate.axis.y}{
The rotation degree of labels on Y axis. The default value is 0.
}
  \item{show.slider.axis.x}{
Whether display slider on X axis. The default value is FALSE.
}
  \item{show.slider.axis.y}{
Whether display slider on Y axis. The default value is FALSE.
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


  dat <- data.frame(c(1, 2, 3, 1),
                      c(2, 4, 6, 6),
                      c(3, 2, 7, 5))
  names(dat) <- c("Type-A", "Type-B", "Type-C")
  row.names(dat) <- c("Time-1", "Time-2", "Time-3", "Time-4")

  # Server function -------------------------------------------
  server <- function(input, output) {
    renderLineChart(div_id = "test",
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

