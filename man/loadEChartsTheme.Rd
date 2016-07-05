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
# please refer to vignettes for the practical examples
loadEChartsTheme(theme = "roma")
}

