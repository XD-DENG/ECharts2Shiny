###########################################################################
# Heat Map ----------------------------------------------------------------
###########################################################################

renderHeatMap <- function(div_id, data,
                          theme = "default",
                          show.tools = TRUE,
                          grid_left = "3%", grid_right = "4%", grid_top = "16%", grid_bottom = "3%",
                          running_in_shiny = TRUE){

  data <- isolate(data)

  if((is.matrix(data) == FALSE) | ((class(data[1, 1]) %in% c("numeric", "integer")) == FALSE)){
    stop("The data input must be a matrix containing numeric or integer values")
  }

  # This is to process NA values. If there is NA values, it will be changed into "null" to be consistent with Javascript
  # The values in the matrix will turn to be "character". This is also why we save it separately as a new variable (we still need the NUMERIC values in the raw data to compute max and min values)
  processed_data <- .process_NA(data)

  # Check the value for theme
  theme_placeholder <- .theme_placeholder(theme)

  # Check logical variables (whether they're logical)
  .check_logical(c('show.tools','running_in_shiny'))

  # Convert raw data into JSON format
  series_data <- paste0("[{type: 'heatmap',data:", .prepare_data_for_heatmap(processed_data), ",itemStyle: {emphasis: {shadowBlur: 10,shadowColor: 'rgba(0, 0, 0, 0.5)'}}}]")

  # prepare axis labels

  row_names <- row.names(data)
  col_names <- colnames(data)


  js_statement <- paste0("var ",
                        div_id,
                        " = echarts.init(document.getElementById('",
                        div_id,
                        "')",
                        theme_placeholder,
                        ");",

                        "option_", div_id, "={tooltip:{position: 'top'}, ",

                        ifelse(show.tools,
                               "toolbox: {feature: {saveAsImage: {}}},",
                               ""),

                        "grid: {left:'", grid_left, "', right:'", grid_right, "', top:'", grid_top, "', bottom:'", grid_bottom, "', containLabel: true},",

                        "xAxis: {type: 'category',data: [",
                        ifelse(is.null(row_names),
                               "' '",
                               paste(sapply(row_names,
                                            function(x){
                                              paste0("'", x, "'")
                                            }), collapse = ",")),
                        "],splitArea: {show: true}},",


                        "yAxis: {type: 'category',data: [",
                        ifelse(is.null(col_names),
                               "' '",
                               paste(sapply(col_names,
                                            function(x){
                                              paste0("'", x, "'")
                                            }), collapse = ",")),
                        "],splitArea: {show: true}},",

                        "visualMap: {min: ", min(data[is.na(data)==FALSE]), ",max: ", max(data[is.na(data)==FALSE]), ",bottom: '15%', show:false},",

                        "series:",
                        series_data,
                        "};",

                        div_id,
                        ".setOption(option_",
                        div_id,
                        ");",

                        "window.addEventListener('resize', function(){",
                        div_id, ".resize()",
                        "});")

  to_eval <- paste0("output$", div_id ," <- renderUI({tags$script(\"",
                   js_statement,
                   "\")})")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }

}
