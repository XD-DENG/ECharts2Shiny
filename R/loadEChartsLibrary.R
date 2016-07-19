loadEChartsLibrary <- function(){
  to_eval='includeScript(system.file("echarts.js", package = "ECharts2Shiny"))'
  eval(parse(text = to_eval), envir = parent.frame())
}

