\name{renderWordcloud}
\alias{renderWordcloud}
\title{
Render the Word Cloud Plotted by ECharts into Shiny Application
}
\description{
renderWordcloud() function helps render the word cloud charts into Shiny applications.
}
\usage{
renderWordcloud(div_id, data, shape,
                grid_size = 5, sizeRange = c(15, 50),
                rotationRange = c(-45, 45),
                running_in_shiny = TRUE)
}
\arguments{
  \item{div_id}{
The division id users specified for this chart. The division will be specified in ui.R.
}
  \item{data}{
  The data used for the plotting. It should be either a vector or a data.frame.

  If it's a vector, it should be made up of all the elements you want to count and plot, like c("a", "a", "b", "a", "b", "c").

  If it's a data.frame, the data must be made up of only two columns, "name" and "value". The "value" column must be numeric or integer.
}
   \item{shape}{
   The shape of the word cloud. The valid values include "circle" (default value), "cardioid", "diamond", "triangle-forward", "triangle", "pentagon" and "star".
  }
  \item{grid_size}{
 The size of the grid in word cloud.
}
  \item{sizeRange}{
 The font size range in the word cloud. It should be a vector of length two. The default value is c(15, 50).
}
  \item{rotationRange}{
 The rotation angle range in the word cloud. It should be a vector of length two. The default value is c(-45, 45).
}
  \item{running_in_shiny}{
      If we're actually running this in a Shiny library, or we're simply doing testing. Default valus is "TRUE". If "FALSE", the function will print what it's supposed to evaluate.
}
}

\references{
https://github.com/ecomfe/echarts-wordcloud
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

sample_data_for_wordcloud <- data.frame(name = c("Asia", "Africa", "North America", "South America",
                                                 "Antarctica", "Europe", "Australia"),
                                        value = c(44391162, 30244049, 24247039, 17821029, 14245000,
                                                  10354636, 7686884))

  renderWordcloud("test_1", data =sample_data_for_wordcloud,
                  grid_size = 10, sizeRange = c(20, 50),
                  running_in_shiny = FALSE)
}
