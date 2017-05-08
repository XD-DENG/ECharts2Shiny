loadEChartsTheme <- function(theme){

  # Check if the value entered for "theme" is valid
  valid_values <- c("roma", "infographic", "macarons", "vintage", "shine", "caravan", "dark-digerati", "jazz", "london")

  if((theme %in% valid_values) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage', 'shine', 'caravan', 'dark-digerati', 'jazz', and 'london'.")
  }

  to_eval=paste('includeScript(system.file("',
                theme,
                '.js", package = "ECharts2Shiny"))',
                sep="")
  eval(parse(text = to_eval), envir = parent.frame())
}

