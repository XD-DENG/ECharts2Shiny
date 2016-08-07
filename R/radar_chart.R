###########################################################################
# Radar Charts ------------------------------------------------------------
###########################################################################


renderRadarChart <- function(div_id,
                             data, theme = "default",
                             shape = "default", line.width = 2,
                             show.legend = TRUE, show.tools = TRUE,
                             font.size.legend = 12,
                             animation = TRUE,
                             running_in_shiny = TRUE){

  data <- isolate(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # check the value for "shape"
  valid_shapes <- c("default", "circle")
  if((shape %in% valid_shapes) == FALSE){
    stop("The shape is invalid. You can choose 'default' or 'circle'.")
  }


  legend_data <- paste(sapply(names(data), function(x){paste("'", x, "'", sep="")}), collapse=", ")
  legend_data <- paste("[", legend_data, "]", sep="")

  indicator <- paste(sapply(1:dim(data)[1],
                            function(i){
                              paste("{name:'", row.names(data)[i],
                                    "', max:",
                                    max(data[i,])*1.1,
                                    "}",
                                    sep="")
                            }),
                     collapse = ",")
  indicator <- paste("indicator:[",
                     indicator,
                     "]")

  # Convert raw data into JSON format
  data <- paste(sapply(1:dim(data)[2],
                       function(i){
                         paste("{value:[",
                               paste(data[, i], collapse = ","),
                               "], name:'",
                               names(data)[i],
                               "'}",
                               sep="")
                       }),
                collapse = ",")


  js_statement <- paste("var " ,
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",
                        "option_", div_id, " = {tooltip:{}, ",

                        ifelse(show.tools,
                               "toolbox:{feature:{saveAsImage:{}}}, ",
                               ""),

                        ifelse(animation,
                               "animation:true,",
                               "animation:false,"),

                        ifelse(show.legend,
                               paste("legend:{orient: 'vertical', left: 'left', data:",
                                     legend_data,
                                     ", textStyle:{fontSize:", font.size.legend, "}",
                                     "},",
                                     sep=""),
                               ""),
                        "radar:{",
                        ifelse(shape == "default",
                               "",
                               "shape: 'circle',"),
                        indicator,
                        "},",
                        "series : [{type: 'radar',",
                        "data:[",
                        data,
                        "], itemStyle: {normal:{lineStyle: {width:", line.width, "}},emphasis : {areaStyle: {color:'rgba(0,250,0,0.3)'}}}}]};",

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
