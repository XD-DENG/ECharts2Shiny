# ECharts2Shiny包
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/ECharts2Shiny)](http://cran.r-project.org/web/packages/ECharts2Shiny)

- [English Version](#echarts2shiny)

![](http://me.seekingqed.com/files/NOT_remove_for_ECharts2Shiny_repo_new.png)

ECharts2Shiny作为一个R包，可以帮助在Shiny应用程序中插入由[*ECharts*](https://github.com/ecomfe/echarts)库绘出的交互图形。当前支持的图形包括

- 饼图 （pie chart）
- 折线图 （line chart）
- 柱形图 （bar chart）
- 散点图 (scatter chart)
- 雷达图 (radar chart)
- 仪表盘 （gauge）
- 词云 （word cloud）
- 热力图 (heat map)


###目录
- [安装](#安装)
- [特点](#特点)
- [例子](#例子)
- [许可证](#许可证)


##安装

**(鉴于我们仍在努力添加更多新的功能到ECharts2Shiny当中，我们更推荐由GitHub安装最新的开发版本。)**

CRAN版本
```{r}
install.packages("ECharts2Shiny")
```

由GitHub安装最新开发版本
```{r}
library(devtools)
install_github("XD-DENG/ECharts2Shiny")
```

## 特点
**简洁易用**：只需要3-4行函数，即可在Shiny应用当中插入一个交互图形。

**可定制图形**：在这个R包中，我尽量保留了ECharts库中的各个可选项，包括grid等。

**可选主题**：与原生的ECharts库一致，用户可选择使用多个主题，包括'roma'， 'shine'， 'vintage'， 'maracons'， 以及'infographic'。用户可根据自己的需要及偏好， 为图形选择不同风格的主题。



##例子
**(请参考`/examples` 文件夹以获得更多实例信息)**

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


## 许可证

***ECharts2Shiny*** 包使用GLP－2许可证。

The ***ECharts*** JS库使用BSD许可证([ECharts](https://github.com/ecomfe/echarts))。
