# ECharts2Shiny
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/ECharts2Shiny)](http://cran.r-project.org/web/packages/ECharts2Shiny)

- [中文版](#echarts2shiny包)

As a R package, *ECharts2Shiny* can help embed the interactive charts plotted by *ECharts* library into our *Shiny* application. Currently, we can support pie charts, line charts, bar charts, scatter plots, and gauge.

- [How to Install](#how-to-install)
- [Features](#features)
- [Examples](#examples)
- [How It Works](#how-it-works)


## How to Install

```{r}
install.packages("ECharts2Shiny")
```

## Features

**Easy to Use**: Only 3-4 lines are needed to insert an interactive chart into our Shiny application.

**Customisable**: As rich options as possible are kept, including the 'grid' option in the original *ECharts* library.

**Theme Options**: In line with the original ECharts library, users can select the theme for their interactive charts, including 'roma', 'shine', 'vintage', 'maracons', and 'infographic'. Users can select the theme of diverse fashion according to their needs and preference.



## Examples

ui.R

```{r}
library(shiny)
library(ECharts2Shiny)

shinyUI(fluidPage(
  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme('shine'),
  loadEChartsTheme('vintage'),

  fluidRow(
    column(6,
           tags$div(id="test_1", style="width: '80%';height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
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
)
```

server.R

```{r}
library(shiny)
library(ECharts2Shiny)

# Prepare sample data for plotting ---------------------------------------

dat_1 <- data.frame(matrix(c(3,2,8), 1,3))
names(dat_1) <- c("Type-A", "Type-B", "Type-C")


dat_2 <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat_2) <- c("Type-A", "Type-B", "Type-C")
row.names(dat_2) <- c("Time-1", "Time-2", "Time-3", "Time-4")

shinyServer(function(input, output) {

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
  })
```
![example](http://me.seekingqed.com/files/do_NOT_remove-used_by_ECharts2Shiny_repo.png)




# How It Works

*ECharts2Shiny* will create the `www/` folder in the Shiny application directory (if there is not one) and copy the Javascript library file of ECharts into the `www/` folder. Then it will work as a wrapper of the `tags$script()` function of *shiny* to load the JS file and plot the charts in Shiny application.

The JS file of ECharts library is embeded in this package. We have a specific function to help us prepare it for using it in Shiny application so users don't need to worry about the Javascript file at all. The only "extra" work we need to do is to add one line in the beginnign part of UI component of ui.R file.
```
loadEChartsLibrary()
```
(You may need to add one comma at the end of this line. You should know why if you have the basic knowledge of the ui.R file in Shiny).

Actually, the .js library file can also be downloaded directly from internet.
```{r}
tags$script(src="http://echarts.baidu.com/dist/echarts.min.js")
```
But I didn't choose this options due to (1) this may make the application slow if we have weak internet connection; (2) sometimes the application may be deployed in environment without internet connection.





# ECharts2Shiny包
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/ECharts2Shiny)](http://cran.r-project.org/web/packages/ECharts2Shiny)

ECharts2Shiny作为一个R包，可以帮助在Shiny应用程序中插入由ECharts库绘出的交互图形。当前支持的图形包括饼图（pie chart），折线图（line chart），柱形图（bar chart），以及仪表盘（gauge）。

该包仍处于开发模式，但基本功能已可用。

- [安装](#安装)
- [特点](#特点)
- [例子](#例子)
- [原理](#原理)


##安装

```{r}
install.packages("ECharts2Shiny")
```

## 特点
**简洁易用**：只需要3-4行函数，即可在Shiny应用当中插入一个交互图形。

**可定制图形**：在这个R包中，我尽量保留了ECharts库中的各个可选项，包括grid等。

**可选主题**：与原生的ECharts库一致，用户可选择使用多个主题，包括'roma'， 'shine'， 'vintage'， 'maracons'， 以及'infographic'。用户可根据自己的需要及偏好， 为图形选择不同风格的主题。



##例子
ui.R

```{r}
library(shiny)
library(ECharts2Shiny)

shinyUI(fluidPage(
  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),
  loadEChartsTheme('shine'),
  loadEChartsTheme('vintage'),

  fluidRow(
    column(6,
           tags$div(id="test_1", style="width: '80%';height:300px;"),  # Specify the div for the chart. Can also be considered as a space holder
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
)
```

server.R

```{r}
library(shiny)
library(ECharts2Shiny)

# Prepare sample data for plotting ---------------------------------------

dat_1 <- data.frame(matrix(c(3,2,8), 1,3))
names(dat_1) <- c("Type-A", "Type-B", "Type-C")


dat_2 <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat_2) <- c("Type-A", "Type-B", "Type-C")
row.names(dat_2) <- c("Time-1", "Time-2", "Time-3", "Time-4")

shinyServer(function(input, output) {

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
  })
```
![example](http://me.seekingqed.com/files/do_NOT_remove-used_by_ECharts2Shiny_repo.png)


##原理
ECharts2Shiny会在用户的Shiny应用所辖的www/文件夹中插入ECharts的Javascript library文件，之后使用*shiny*的`tags$script()`函数来读取javascript文件并在最终的shiny应用中运行。

