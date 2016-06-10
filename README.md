# ECharts2Shiny
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
