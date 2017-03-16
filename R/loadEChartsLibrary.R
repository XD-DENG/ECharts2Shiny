loadEChartsLibrary <- function(){
  to_eval='includeScript(system.file("echarts.min.js", package = "ECharts2Shiny"))'
  eval(parse(text = to_eval), envir = parent.frame())
  to_eval='includeScript(system.file("wordcloud.min.js", package = "ECharts2Shiny"))'
  eval(parse(text = to_eval), envir = parent.frame())
}

