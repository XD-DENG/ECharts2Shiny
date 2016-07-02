\name{renderPieChart}
\alias{renderPieChart}

\title{
Render the Pie Chart Plotted by ECharts into Shiny Application
}
\description{
renderPieChart() function helps render the pie chart into Shiny application.
}
\usage{
renderPieChart(div_id, data, theme, radius,center_x,center_y,running_in_shiny)
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
  \item{radius}{
The radius of the pie chart.
}
  \item{center_x}{
The position of the center of the pie chart (x axis). Default value is "50\%".
}
  \item{center_y}{
The position of the center of the pie chart (y axis). Default value is "50\%".
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
# please refer to vignettes for the practical examples

# Prepare sample data for plotting
dat <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat) <- c("Type-A", "Type-B", "Type-C")
row.names(dat) <- c("Time-1", "Time-2", "Time-3", "Time-4")

renderPieChart(div_id = "test", data = dat, running_in_shiny = FALSE)

}
