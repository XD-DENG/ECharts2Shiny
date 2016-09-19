###########################################################################
# Tree Map ---------------------------------------------------------------
###########################################################################


renderTreeMap <- function(div_id,
                           data,
                           name = "Main",
                           leafDepth = 2,
                           theme = "default",
                           show.tools = TRUE,
                           animation = TRUE,
                           running_in_shiny = TRUE){



  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)


  js_statement <- paste("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",

                        "option_", div_id,
                        " = {tooltip : {trigger:'item', formatter: '{b}: {c}'}, ",

                        ifelse(show.tools,
                               "toolbox:{feature:{mark:{show:true}, restore:{show: true}, saveAsImage:{}}}, ",
                               ""),

                        ifelse(animation,
                               "animation:true,",
                               "animation:false,"),

                        "series :[",

                        "{name:'", name, "',",
                        "type:'treemap',",
                        "leafDepth:", leafDepth, ",",

                        " itemStyle:{normal: {label: {show: true,formatter: '{b}'},borderWidth: 1},emphasis: {label: {show: true}}},",

                        "data:[",
                        data,
                        "]",

                        "}]",

                        "};",

                        div_id,
                        ".setOption(option_",
                        div_id,
                        ");",

                        "window.addEventListener('resize', function(){",
                        div_id, ".resize()",
                        "});",

                        sep="")

  to_eval <- paste("output$", div_id ," <- renderUI({fluidPage(tags$script(\"",
                   js_statement,
                   "\"))})",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}
