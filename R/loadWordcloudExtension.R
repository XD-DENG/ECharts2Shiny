loadWordcloudExtension <- function(){

  to_eval='includeScript(system.file("echarts_wordcloud.js", package = "ECharts2Shiny"))'

  eval(parse(text = to_eval), envir = parent.frame())

}

