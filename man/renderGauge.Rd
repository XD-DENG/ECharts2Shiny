\name{renderGauge}
\alias{renderGauge}

\title{
Render the Gauge Chart Plotted by ECharts into Shiny Application
}
\description{
renderGauge() function helps render the gauge chart into Shiny application.
}
\usage{
renderGauge(div_id, theme = "default", gauge_name, rate, 
            show.tools = TRUE, 
            animation = TRUE,
            running_in_shiny = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{div_id}{
  The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{theme}{
  Which ECharts theme to use. Valid values include "default", "roma", "infographic", "macarons", "vintage", "shine".
}
  \item{gauge_name}{
  The title to show on the gauge
}
  \item{rate}{
  As the gauge helps show some kind of rate, users need to give this rate value.
}
  \item{show.tools}{
If display the tool bar. The default value is TRUE.
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
# please refer to vignettes for the practical examples
renderGauge(div_id = "abc", gauge_name = "test", rate = 0.99, running_in_shiny = FALSE)
}

