placeholder.PieChart <- function(div_id,
                           width = "100%",
                           height = "200px",
                           running_in_shiny = TRUE){
  to_eval <- paste("tags$div(id='",
                   div_id,
                   "', style = \"width:'",
                   width,
                   "';height:'",
                   height, "';\")",
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



