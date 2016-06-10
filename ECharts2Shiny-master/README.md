# ECharts2Shiny
Use ECharts in Shiny Applications


## Note

### Pre-work 

[1] Install this package

[2] Deploy the ECharts JS library file

To use the ECharts library in Shiny application, we need to copy the library .js file (*echarts.js*) into the "www" folder of the Shiny application.

Additionally, in the beginning of *ui.R* file, we need to have a line
```{r}
tags$script(src="echarts.js"),
```
to call the .js library file.

Instead, we can also download the .js library file directly from internet. To do this, we need to add a line
```{r}
tags$script(src="http://echarts.baidu.com/dist/echarts.min.js")
```
