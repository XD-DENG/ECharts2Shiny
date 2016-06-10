loadEChartsLibrary <- function(running_in_shiny = TRUE){

  # Copy the JS library file to the Shiny App "www" folder
  if(dir.exists("www/") == FALSE){
    dir.create("www/")
  }

  lib_path <- system.file("echarts.js", package = "ECharts2Shiny")
  file.copy(lib_path, "www/echarts.js")

  to_eval <- paste('tags$script(src="echarts.js")')

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}

