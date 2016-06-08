outputPieChart <- function(div_name,
                           width,
                           height,
                           running_in_shiny = TRUE){
  to_eval <- paste("tags$div(id='",
                   div_name,
                   "', style = \"width:'",
                   width, 
                   "';height:",
                   height, ";\")",
                   sep="")
  
  if(running_in_shiny == TRUE){
    eval(parse(text = paste("tags$script(",
                            to_eval,
                            ")",
                            sep=""))
    )
  } else {
    cat(to_eval)
  }
}

outputPieChart("Test", "100%", "300px",
               running_in_shiny = FALSE)

