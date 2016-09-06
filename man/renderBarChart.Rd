\name{renderBarChart}
\alias{renderBarChart}

\title{
Render the Bar Chart Plotted by ECharts into Shiny Application
}
\description{
renderBarChart() function helps render the bar chart into Shiny application.
}
\usage{
renderBarChart(div_id, data, theme,
               stack_plot = FALSE, direction = "horizontal",
               grid_left,grid_right, grid_top, grid_bottom,
               show.legend = TRUE, show.tools = TRUE,
               font.size.legend = 12,
               font.size.axis.x = 12, font.size.axis.y = 12,
               rotate.axis.x = 0, rotate.axis.y = 0,
               bar.max.width = NULL,
               animation = TRUE,
               running_in_shiny)
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
  \item{stack_plot}{
Whether do stack bar chart. The default value is FALSE.
}
  \item{direction}{
  The direction of the bar chart. Valid values include "vertical" and "horizontal". Default value is "horizontal".
}
  \item{grid_left}{
  The grid left for the left side. Default value is "3\%".
}
  \item{grid_right}{
  The grid left for the right side. Default value is "4\%".
}
  \item{grid_top}{
  The grid left for the top side. Default value is "16\%".
}
  \item{grid_bottom}{
  The grid left for the bottom side. Default value is "3\%".
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
  \item{bar.max.width}{
The maximum width of the bar. The default value is NULL, in which case the bar width and maximum width will be automatically adjusted.

Users can also assign a numeric value to it, to customize the maximum bar width. If the width is too big or invalid value (like a character string), it will be automatically adjusted too.
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

  # Prepare sample data for plotting --------------------------
  dat <- data.frame(c(1, 2, 3),
                    c(2, 4, 6))
  names(dat) <- c("Type-A", "Type-B")
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

