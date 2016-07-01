\name{loadEChartsTheme}
\alias{loadEChartsTheme}
\title{
Load the Theme File of ECharts to the Shiny Application
}
\description{
This function will help load the theme file of ECharts into the current Shiny application. This is not mandatory for the basic use of this package. But if users want to try different theme, they need to load the corresponding theme file.
}
\usage{
loadEChartsTheme(theme, running_in_shiny = TRUE)
}
\arguments{
  \item{theme}{
  The theme file users want to use. The valid values include "infographic", "macarons", "roma", "shine", and "vintage".
}
  \item{running_in_shiny}{
  If we're actually running this in a Shiny library, or we're simply doing testing. Default valus is "TRUE". If "FALSE", the function will print what it's supposed to evaluate.
}
}
\details{
  Users can simply use the default theme. But if they want to try different theme of the charts, they need to load the corresponding JS file.The theme files are not loaded automatically so that we don't have to include unnecessary files into the Shiny applications (you only include what you need).
}

\author{
  Xiaodong DENG

  (ECharts library is authored by Baidu team)
}
\note{
  Please note that the files will be written into your Shiny application directory.
}

\examples{
# please refer to vignettes for the practical examples
loadEChartsTheme(theme = "roma", running_in_shiny = FALSE)
}

