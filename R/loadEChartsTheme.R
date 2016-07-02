loadEChartsTheme <- function(theme,
                               running_in_shiny = TRUE){

  valid_values <- c("roma", "infographic", "macarons", "vintage", "shine")

  if((theme %in% valid_values) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'roma', 'infographic', 'macarons', 'vintage' and 'shine'.")
  }

  # Copy the JS theme file to the Shiny App "www" folder
  if(dir.exists("www/") == FALSE){
    dir.create("www/")
  }

  lib_path <- system.file(paste(theme, ".js", sep=""), package = "ECharts2Shiny")
  file.copy(lib_path, paste("www/", theme, ".js", sep=""))

  to_eval <- paste('tags$script(src="', theme, '.js")', sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval), envir = parent.frame())
  } else {
    cat(to_eval)
  }
}

