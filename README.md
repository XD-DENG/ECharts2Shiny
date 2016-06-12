# ECharts2Shiny

ECharts2Shiny作为一个R包，可以帮助在Shiny应用程序中插入由ECharts库绘出的交互图形。当前支持的图形包括饼图（pie chart），折线图（line chart），柱形图（bar chart），以及仪表盘（gauge）。

该包仍处于开发模式，但基本功能已可用。

## 特点
**简洁易用**：只需要3-4行函数，即可在Shiny应用当中插入一个交互图形。

**可定制图形**：在这个R包中，我尽量保留了ECharts库中的各个可选项，包括grid等。

**可选主题**：与原生的ECharts库一致，用户可选择使用多个主题，包括'roma'， 'shine'， 'vintage'， 'maracons'， 以及'infographic'。用户可根据自己的需要， 为图形选择不同风格的主题。

##例子
ui.R

```{r}
library(shiny)
library(ECharts2Shiny)

shinyUI(fluidPage(

  # We HAVE TO to load the ECharts javascript library in advance
  loadEChartsLibrary(),

  tags$div(id="test", style="width:80%;height:300px;"),
  deliverChart(div_id = "test")
  )
)
```

server.R

```{r}
library(shiny)
library(ECharts2Shiny)

# Prepare sample data for plotting
dat <- data.frame(c(1, 2, 3, 1),
                  c(2, 4, 6, 6),
                  c(3, 2, 7, 5))
names(dat) <- c("Type-A", "Type-B", "Type-C")
row.names(dat) <- c("Time-1", "Time-2", "Time-3", "Time-4")


shinyServer(function(input, output) {

  # Call functions from ECharts2Shiny to render charts
  renderBarChart(div_id = "test", grid_left = '1%',
                 data = dat)
  })

```
![example](http://me.seekingqed.com/files/do_NOT_remove-used_by_ECharts2Shiny_repo.png)

##原理
ECharts2Shiny会在用户的Shiny应用所辖的www/文件夹中插入ECharts的javascript library文件，之后使用＊shiny＊的`tags$script()`函数来读取javascript文件并在最终的shiny应用中运行。






Use ECharts in Shiny Applications

## How we deployed the javascript library file

Actually the .js file of ECharts library is embeded in this package. When we use this package in the Shiny application, we need to call function `loadEChartsLibrary()`. This function will help copy the javascript file into the `www/` directory in your application automatically (the `www/` folder will be built if there isn't one).

So users don't need to worry about the javascript library file at all. The only "extra" work we need to do is to add one line in the beginnign part of UI component of ui.R file
```
loadEChartsLibrary()
```
(You may need to add one comma at the end of this line. You should know why if you have the basic knowledge of the ui.R file in Shiny).

Actually, the .js library file can also be downloaded directly from internet.
```{r}
tags$script(src="http://echarts.baidu.com/dist/echarts.min.js")
```
But I didn't choose this options due to (1) this may make the application slow if we have weak internet connection; (2) sometimes the application may be deployed in environment without internet connection.
