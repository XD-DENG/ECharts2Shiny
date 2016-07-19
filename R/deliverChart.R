deliverChart <- function(div_id,
                        running_in_shiny = TRUE){
  
  to_eval <- paste("uiOutput(\"",
                   div_id,
                   "\")",
                   sep="")

  if(running_in_shiny == TRUE){
    eval(parse(text = to_eval)
    )
  } else {
    cat(to_eval)
  }
}

