# ECharts2Shiny
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/ECharts2Shiny)](http://cran.r-project.org/web/packages/ECharts2Shiny/)

- [中文版](#echarts2shiny包)

<p align="center">
<img src="http://me.seekingqed.com/files/NOT_remove_for_ECharts2Shiny_repo_new.png" alt="Drawing" style="width:80%;"/>
</p>

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
- [Examples](#examples)
- [License](#license)


## How to Install

From CRAN,
```{r}
install.packages("ECharts2Shiny")
```

For the latest development version, please install from GitHub
```{r}
library(devtools)
install_github("XD-DENG/ECharts2Shiny")
```

## Examples


```{r}
library(shiny)
library(ECharts2Shiny)

# Prepare sample data for plotting --------------------------
dat <- data.frame(c(1, 2, 3),
                  c(2, 4, 6))
names(dat) <- c("Type-A", "Type-B")
row.names(dat) <- c("Time-1", "Time-2", "Time-3")

# Server function -------------------------------------------
server <- function(input, output) {
  # Call functions from ECharts2Shiny to render charts
  renderBarChart(div_id = "test", grid_left = '1%', direction = "vertical",
                 data = dat)
}

# UI layout -------------------------------------------------
ui <- fluidPage(
  # We MUST load the ECharts javascript library in advance
  loadEChartsLibrary(),
  
  tags$div(id="test", style="width:50%;height:400px;"),
  deliverChart(div_id = "test")
)

# Run the application --------------------------------------
shinyApp(ui = ui, server = server)
```
<p align="center">
<img src="http://me.seekingqed.com/files/do_NOT_remove-used_by_ECharts2Shiny_repo.png" alt="Drawing" style="width:50%;"/>
</p>

**(For more examples, please refer to the `/examples` folder)**

### List of Examples

- [1. Basic](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-1%20Basic)
- [2. Diverse Plots](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-2%20Diverse%20Plots)
- [3. More Options in Basic Charts](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-3%20More%20Options)
- [4. Scatter](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-4%20Scatter)
- [5. Use Reactive Values as Data Input](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-5%20Use%20Reactive%20Values)
- [6. Radar Chart](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-6%20Radar%20Chart)
- [7. Word Cloud - Basic](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-7%20word%20cloud)
- [8. Word Cloud - More Shapes](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-8%20word%20cloud%20-%20more%20shapes)
- [9. Word Cloud - Use Vector as Data Input](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-9%20word%20cloud%20-%20Use%20vector%20as%20data%20input)
- [10. Line Chart with Diverse Options](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-10%20Line%20Chart%20with%20diverse%20options)
- [11. Scatter with point.type Argument](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-11%20Scatter%20with%20point.type)
- [12. Step Line Chart](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-12%20Step%20Line%20Chart)
- [13. Deal with Missing Values](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-13%20Deal%20with%20NA%20Values)
- [14. Heat Map](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-14%20Heat%20Map)


## License

***ECharts2Shiny*** package itself is under GPL-2. 

The ***ECharts*** JS library is under BSD license ([ECharts](https://github.com/ecomfe/echarts)).


# ECharts2Shiny包
[![CRAN Status Badge](http://www.r-pkg.org/badges/version/ECharts2Shiny)](http://cran.r-project.org/web/packages/ECharts2Shiny/)

- [English Version](#echarts2shiny)

<p align="center">
<img src="http://me.seekingqed.com/files/NOT_remove_for_ECharts2Shiny_repo_new.png" alt="Drawing" style="width:80%;"/>
</p>

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
- [例子](#例子)
- [许可证](#许可证)


##安装

CRAN版本
```{r}
install.packages("ECharts2Shiny")
```

由GitHub安装最新开发版本
```{r}
library(devtools)
install_github("XD-DENG/ECharts2Shiny")
```

##例子

```{r}
library(shiny)
library(ECharts2Shiny)

# Prepare sample data for plotting --------------------------
dat <- data.frame(c(1, 2, 3),
                  c(2, 4, 6))
names(dat) <- c("Type-A", "Type-B")
row.names(dat) <- c("Time-1", "Time-2", "Time-3")

# Server function -------------------------------------------
server <- function(input, output) {
  # Call functions from ECharts2Shiny to render charts
  renderBarChart(div_id = "test", grid_left = '1%', direction = "vertical",
                 data = dat)
}

# UI layout -------------------------------------------------
ui <- fluidPage(
  # We MUST load the ECharts javascript library in advance
  loadEChartsLibrary(),
  
  tags$div(id="test", style="width:50%;height:400px;"),
  deliverChart(div_id = "test")
)

# Run the application --------------------------------------
shinyApp(ui = ui, server = server)
```

<p align="center">
<img src="http://me.seekingqed.com/files/do_NOT_remove-used_by_ECharts2Shiny_repo.png" alt="Drawing" style="width:50%;"/>
</p>

**(请参考`/examples` 文件夹以获得更多实例信息)**
### 实例列表

- [1. Basic](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-1%20Basic)
- [2. Diverse Plots](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-2%20Diverse%20Plots)
- [3. More Options in Basic Charts](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-3%20More%20Options)
- [4. Scatter](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-4%20Scatter)
- [5. Use Reactive Values as Data Input](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-5%20Use%20Reactive%20Values)
- [6. Radar Chart](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-6%20Radar%20Chart)
- [7. Word Cloud - Basic](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-7%20word%20cloud)
- [8. Word Cloud - More Shapes](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-8%20word%20cloud%20-%20more%20shapes)
- [9. Word Cloud - Use Vector as Data Input](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-9%20word%20cloud%20-%20Use%20vector%20as%20data%20input)
- [10. Line Chart with Diverse Options](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-10%20Line%20Chart%20with%20diverse%20options)
- [11. Scatter with point.type Argument](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-11%20Scatter%20with%20point.type)
- [12. Step Line Chart](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-12%20Step%20Line%20Chart)
- [13. Deal with Missing Values](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-13%20Deal%20with%20NA%20Values)
- [14. Heat Map](https://github.com/XD-DENG/ECharts2Shiny/tree/master/examples/example-14%20Heat%20Map)


## 许可证

***ECharts2Shiny*** 包使用GLP－2许可证。

The ***ECharts*** JS库使用BSD许可证([ECharts](https://github.com/ecomfe/echarts))。
