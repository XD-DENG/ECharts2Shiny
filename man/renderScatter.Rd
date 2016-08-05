\name{renderScatter}
\alias{renderScatter}
\title{
Render the Scatter Plots Plotted by ECharts into Shiny Application
}
\description{
renderScatter() function helps render the scatter plots into Shiny applications.
}
\usage{
renderScatter(div_id, data,
              point.size = 10, point.type = "circle",
              theme = "default", auto.scale = TRUE,
              show.legend = TRUE, show.tools = TRUE,
              font.size.legend = 12,
              font.size.axis.x = 12, font.size.axis.y = 12,
              rotate.axis.x = 0, rotate.axis.y = 0,
              show.slider.axis.x = FALSE, show.slider.axis.y = FALSE,
              animation = TRUE,
              running_in_shiny = TRUE)
}
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
  The data used for the plotting. It should be a data.frame. For scatter plots, the data must be made up of three columns, "x", "y", and "group".
}
  \item{point.size}{
This argument helps set the size of points in the scatter plots. It should be a single numeric or integer value. The dafault value is 10.
}
  \item{point.type}{
The shape of the points in scatter plots.

Valid values include 'emptyCircle', 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow'. The default value is 'circle'.

The length of this argument should either be one or be the same as the number of UNIQUE groups (the number of unique elements in 'group' column of the data input).
}
  \item{theme}{
Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{auto.scale}{
A logical argument to determine if the scatter plot should be scaled again automatically after the users exclude any group of observations. The default value is TRUE.
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


  dat <- data.frame(x = iris$Sepal.Length,
                    y = iris$Sepal.Width,
                    group = iris$Species)


  # Server function -------------------------------------------
  server <- function(input, output) {
    renderScatter("test", data = dat)
  }

  # UI layout -------------------------------------------------
  ui <- fluidPage(
    # We MUST load the ECharts javascript library in advance
    loadEChartsLibrary(),

    tags$div(id="test", style="width:100\%;height:500px;"),
    deliverChart(div_id = "test")
  )

  # Run the application --------------------------------------
  shinyApp(ui = ui, server = server)
}

}

