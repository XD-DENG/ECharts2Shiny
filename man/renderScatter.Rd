\name{renderScatter}
\alias{renderScatter}
\title{
Render the Scatter Plots Plotted by ECharts into Shiny Application
}
\description{
renderScatter() function helps render the scatter plots into Shiny application.
}
\usage{
renderScatter(div_id, data, theme = "default",
              show.legend = TRUE, show.tools = TRUE,
              running_in_shiny = TRUE)
}
\arguments{
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
  The data used for the plotting. It should be a data.frame. For scatter plots, the data must be made up of three columns, "x", "y", and "group".
}
  \item{theme}{
Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{show.legend}{
If display the legends. The default value is TRUE.
}
  \item{show.tools}{
If display the tool bar. The default value is TRUE.
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

dat <- data.frame(x = iris$Sepal.Length,
                  y = iris$Sepal.Width,
                  group = iris$Species)

renderScatter("test", dat, running_in_shiny = FALSE)

}

