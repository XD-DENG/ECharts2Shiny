library(shiny)
library(ECharts2Shiny)

dat <- data.frame(a=c("A", "B", "C"),
                  b=c(1, 2, 3))


shinyServer(function(input, output) {
  # output$Weekly_Total <- renderUI({fluidPage(tags$script("var Weekly_Total = echarts.init(document.getElementById('Weekly_Total'));option_Weekly_Total = {tooltip : {trigger: 'item',formatter: '{a} <br/>{b} : {c} ({d}%)'}, series : [{name: 'Sales Count', type: 'pie', radius:'50%', center :['50%','50%'],data:[{\"name\":\"A\",\"value\":1},{\"name\":\"B\",\"value\":2},{\"name\":\"C\",\"value\":3}], itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]};Weekly_Total.setOption(option_Weekly_Total);"))})
  # output$test <- renderUI({fluidPage(tags$script("var Weekly_Total = echarts.init(document.getElementById('Weekly_Total'));option_Weekly_Total = {tooltip : {trigger: 'item',formatter: '{a} <br/>{b} : {c} ({d}%)'}, series : [{name: 'Sales Count', type: 'pie', radius:'50%', center :['50%','50%'],data:[{'name':'A','value':1},{'name':'B','value':2},{'name':'C','value':3}], itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]};Weekly_Total.setOption(option_Weekly_Total);"))})

  # output$test <- renderUI({
  #   tags$script("var Weekly_Total = echarts.init(document.getElementById('Weekly_Total_1'));option_Weekly_Total = {tooltip : {trigger: 'item',formatter: '{a} <br/>{b} : {c} ({d}%)'}, series : [{name: 'Sales Count', type: 'pie', radius:'50%', center :['50%','50%'],data:[{'name':'A','value':1},{'name':'B','value':2},{'name':'C','value':3}], itemStyle: { emphasis: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]};Weekly_Total.setOption(option_Weekly_Total);")})

  # renderPieChart(div_id = "test", data = dat)
  }


)