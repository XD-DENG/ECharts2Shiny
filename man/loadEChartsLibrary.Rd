\name{loadEChartsLibrary}
\alias{loadEChartsLibrary}

\title{
  Load the Javascript Library File of ECharts to the Shiny Application
}
\description{
  This function will help load the Javascript library file of ECharts to the current shiny project. This is mandatory before we can plot with ECharts in Shiny applications.
}
\usage{
loadEChartsLibrary(running_in_shiny = TRUE)
}

\arguments{
  \item{running_in_shiny}{
    If we're actually running this in a Shiny library, or we're simply doing testing. Default valus is "TRUE". If "FALSE", the function will print what it's supposed to evaluate.
}
}
\details{
  This function will create the "www/" folder in the Shiny application directory (if there is not one). Then the Javascript library file of ECharts will be copied to this "www/" folder.

  This is the preparation for plotting with ECharts in Shiny application.
}


\author{
  Xiaodong DENG

  (ECharts library is authored by Baidu team)
}
\note{
  Please note that the file will be written into your Shiny application directory.
}


\examples{
# please refer to vignettes for the practical examples
loadEChartsLibrary(running_in_shiny = FALSE)
}

