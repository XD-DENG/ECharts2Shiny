###########################################################################
# Gauge -------------------------------------------------------------------
###########################################################################


renderGauge <- function(div_id, theme = "default",
                        gauge_name, rate,
                        show.tools = TRUE,
                        animation = TRUE,
                        running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Convert raw data into JSON format
  series_data <- paste("[{name:'",gauge_name, "',value:", rate, "}]", sep="")

  js_statement <- paste("var ",
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",

                        "option_", div_id, "={tooltip : {formatter: '{b} : {c}%'}, ",

                        ifelse(show.tools,
                               "toolbox: {feature: {saveAsImage: {}}},",
                               ""),

                        ifelse(animation,
                               "animation:true,",
                               "animation:false,"),

                        "series:[{name:'", gauge_name, "', type:'gauge', detail: {formatter:'{value}%'},data:",
                        series_data,
                        "}]};",

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
