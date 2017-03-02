###########################################################################
# Tree Map ---------------------------------------------------------------
###########################################################################


renderTreeMap <- function(div_id,
                           data,
                           name = "Main",
                           leafDepth = 2,
                           theme = "default",
                           show.tools = TRUE,
                           running_in_shiny = TRUE){



  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Check logical variables (whether they're logical)
  .check_logical(c('show.tools', 'running_in_shiny'))

  # Check the value of 'leafDepth'
  if(((class(leafDepth) %in% c('integer', 'numeric')) == FALSE)){
    stop("Argument 'leafDepth' must be integer.")
  }

  if(leafDepth <=0 ){
    stop("Argument 'leafDepth' must be bigger than 0.")
  }

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

                        "series :[",

                        "{name:'", name, "',",
                        "type:'treemap',",
                        "leafDepth:", leafDepth, ",",

                        " itemStyle:{normal: {label: {show: true,formatter: '{b}'},borderWidth: 1},emphasis: {label: {show: true}}},",

                        "data:",
                        data,
                        "",

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

  to_eval <- paste("output$", div_id ," <- renderUI({tags$script(\"",
                   js_statement,
                   "\")})",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}
