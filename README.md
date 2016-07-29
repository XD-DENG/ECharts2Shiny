# ECharts2Shiny
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/ECharts2Shiny)](http://cran.r-project.org/web/packages/ECharts2Shiny)

- [中文版](/README_cn.md)

![](http://me.seekingqed.com/files/NOT_remove_for_ECharts2Shiny_repo_new.png)

As an R package, *ECharts2Shiny* can help embed the interactive charts plotted by [*ECharts*](https://github.com/ecomfe/echarts) library into our *Shiny* application. Currently, we can support 

- Pie charts
- Line charts
- Bar charts
- Scatter plots
- Radar chart
- Gauge
- Word Cloud
- Heat Map

### Contents
- [How to Install](#how-to-install)
- [Features](#features)
- [Examples](#examples)
- [License](#license)


## How to Install

**(As this package is under active development, it's recommended to install the latest development version from GitHub, instead of the CRAN version.)**

From CRAN,
```{r}
install.packages("ECharts2Shiny")
```

For the latest development version, please install from GitHub
```{r}
library(devtools)
install_github("XD-DENG/ECharts2Shiny")
```

## Features

**Easy to Use**: Only 3-4 lines are needed to insert an interactive chart into our Shiny application.

**Customisable**: As rich options as possible are kept, including the 'grid' option in the original *ECharts* library.

**Theme Options**: In line with the original ECharts library, users can select the theme for their interactive charts, including 'roma', 'shine', 'vintage', 'maracons', and 'infographic'. Users can select the theme of diverse fashion according to their needs and preference.



## Examples

**(For more examples, please refer to the `/examples` folder)**

```{r}
library(shiny)
library(ECharts2Shiny)


# Prepare sample data for plotting ---------------------------------------

dat_1 <- c(rep("Type-A", 8),
           rep("Type-B", 5),
           rep("Type-C", 1))

dat_2 <- data.frame(c(1, 2, 3, 1),
                    c(2, 4, 6, 6),
                    c(3, 2, 7, 5))
names(dat_2) <- c("Type-A", "Type-B", "Type-C")
row.names(dat_2) <- c("Time-1", "Time-2", "Time-3", "Time-4")


# Server function ---------------------------------------------------------

server <- function(input, output) {
  
  # Call functions from ECharts2Shiny to render charts
  renderPieChart(div_id = "test_1",
                 data = dat_1,
                 radius = "70%",center_x = "50%", center_y = "50%")
  
  renderLineChart(div_id = "test_2", theme = "shine",
                  data = dat_2)
  
  renderBarChart(div_id = "test_3", grid_left = '1%',
                 data = dat_2)
  
  renderBarChart(div_id = "test_4", theme = "vintage",
                 direction = "vertical", grid_left = "10%",
                 data = dat_2)
  
  renderGauge(div_id = "test_5", gauge_name = "Finished Rate",
              rate = 99.9)
}


# UI layout ---------------------------------------------------------------

ui <- fluidPage(
  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme('shine'),
  loadEChartsTheme('vintage'),
  
  fluidRow(
    column(6,
           tags$div(id="test_1", style="width: 80%;height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
           deliverChart(div_id = "test_1")  # Deliver the plotting
    ),
    column(6,
           tags$div(id="test_2", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_2")
    )
  ),
  
  fluidRow(
    column(6,
           tags$div(id="test_3", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_3")
    ),
    column(6,
           tags$div(id="test_4", style="width:80%;height:300px;"),
           deliverChart(div_id = "test_4")
    )
  ),
  
  fluidRow(
    column(6,
           tags$div(id="test_5", style="width:100%;height:400px;"),
           deliverChart(div_id = "test_5")
    ),
    column(6
    )
  )
)

# Run the application
shinyApp(ui = ui, server = server)
```
![example](http://me.seekingqed.com/files/do_NOT_remove-used_by_ECharts2Shiny_repo.png)


## License

***ECharts2Shiny*** package itself is under GPL-2. 

The ***ECharts*** JS library is under BSD license ([ECharts](https://github.com/ecomfe/echarts)).
