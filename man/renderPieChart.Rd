\name{renderPieChart}
\alias{renderPieChart}

\title{
Render the Pie Chart Plotted by ECharts into Shiny Application
}
\description{
renderPieChart() function helps render the pie chart into Shiny application.
}
\usage{
renderPieChart(div_id, data,
               theme = 'default', radius, center_x,center_y,
               show.label = TRUE,
               show.legend = TRUE, show.tools = TRUE,
               font.size.legend= 12,
               animation = TRUE,
               running_in_shiny)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
  The data used for the plotting. It should be either a vector or a data.frame.

  If it's a vector, it should be made up of all the elements you want to count and plot, like c("a", "a", "b", "a", "b", "c").

  If it's a data.frame, the data must be made up of only two columns, "name" and "value". The "value" column must be numeric or integer.
}
  \item{theme}{
Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{radius}{
The radius of the pie chart. The default value is "75\%".
}
  \item{center_x}{
The position of the center of the pie chart (x axis). Default value is "50\%".
}
  \item{center_y}{
The position of the center of the pie chart (y axis). Default value is "50\%".
}
  \item{show.label}{
Whether display the leble for the pie chart. The default value is TRUE.
}
  \item{show.legend}{
Whether display the legends. The default value is TRUE.
}
  \item{show.tools}{
Whether display the tool bar. The default value is TRUE.
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


  dat <- c(rep("Type-A", 8),
             rep("Type-B", 5),
             rep("Type-C", 1))


  # Server function -------------------------------------------
  server <- function(input, output) {
    renderPieChart(div_id = "test",
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
