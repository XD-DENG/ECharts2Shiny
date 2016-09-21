\name{renderTreeMap}
\alias{renderTreeMap}

\title{
Render Interactive Tree Map into Shiny Application
}
\description{
renderTreeMap() function helps render interactive tree map chart into Shiny application.
}
\usage{
renderTreeMap(div_id,
              data,
              name = "Main",
              leafDepth = 2,
              theme = "default",
              show.tools = TRUE,
              running_in_shiny = TRUE)
}
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
The data used for tree map. Not like other charts, here we need to use JSON data for the tree map charts, since there may be nested data which can be handled by JSON much easilier (please check `example`).
}
  \item{name}{
The name of the tree map chart.
}
  \item{leafDepth}{
It determines when the 'drill down' feature will start to work.

This is for mainly nested data, like we may ave categories 'A-1' and 'A-2' under 'A', and furtherly we have 'A-1-1' and 'A-1-2' under 'A-1'.

The value of this argument must be integer and bigger than 0 (float value will be converted to its ceiling value automatically). The default value is 2.
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
    dat <- "[{name: 'A',
              value: 6,
              children: [
                  {
                  name: 'A-1',
                  value: 6,
                  children:[
                  {
                  name: 'A-1-1',
                  value: 6
                  },
                  {
                  name: 'A-1-2',
                  value: 2
                  }
                  ]
                  },
                  {
                  name: 'A-2',
                  value: 3
                  }
              ]
            },
            {
              name: 'B',
              value: 6,
              children: [
                  {name : 'B-1',
                  value:10
                  },
                  {
                  name:'B-2',
                  value:2
                  }
              ]
            },
            {
              name: 'C',
              value: 4
            }]"

    # Server function -------------------------------------------
    server <- function(input, output) {
      # Call functions from ECharts2Shiny to render charts
      renderTreeMap(div_id = "test",
                    data = dat)
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
