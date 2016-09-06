\name{loadEChartsTheme}
\alias{loadEChartsTheme}
\title{
Load the Theme File of ECharts to the Shiny Application
}
\description{
This function will help load the theme file of ECharts into the current Shiny application. This is not mandatory for the basic use of this package. But if users want to try different theme, they need to load the corresponding theme file.
}
\usage{
loadEChartsTheme(theme)
}
\arguments{
  \item{theme}{
  The theme file users want to use. The valid values include "infographic", "macarons", "roma", "shine", and "vintage".
}
}
\details{
  Users can simply use the default theme. But if they want to try different theme of the charts, they need to load the corresponding JS file.The theme files are not loaded automatically so that we don't have to include unnecessary files into the Shiny applications (you only include what you need).
}

\author{
  Xiaodong DENG

  (ECharts library is authored by Baidu team)
}


\examples{

if (interactive()) {
  library(shiny)
  library(ECharts2Shiny)

  # Prepare sample data for plotting --------------------------
  dat <- data.frame(c(1, 2, 3))
  names(dat) <- c("Type-A")
  row.names(dat) <- c("Time-1", "Time-2", "Time-3")

  # Server function -------------------------------------------
  server <- function(input, output) {
    # Call functions from ECharts2Shiny to render charts
    renderBarChart(div_id = "test", grid_left = '1\%', direction = "vertical",
                   data = dat, theme = "vintage")
  }

  # UI layout -------------------------------------------------
  ui <- fluidPage(
    # We MUST load the ECharts javascript library in advance
    loadEChartsLibrary(),
    loadEChartsTheme("vintage"),

    tags$div(id="test", style="width:50\%;height:400px;"),
    deliverChart(div_id = "test")
  )

  # Run the application --------------------------------------
  shinyApp(ui = ui, server = server)
}


}

