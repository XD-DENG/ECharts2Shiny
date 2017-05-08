
###########################################################################
# Internal Functions ------------------------------------------------------
###########################################################################

# This is a function defined to be used within user-level functions.
# It will help check if the theme argument is valid.
# If it's invalid, give error msg.
# if valid, return the theme place holder statement
.theme_placeholder <- function(theme){

  valid_themes <- c("default", "roma", "infographic", "macarons", "vintage", "shine", "caravan", "dark-digerati", "jazz", "london")
  if((theme %in% valid_themes) == FALSE){
    stop("The ECharts theme you specified is invalid. Please check. Valid values include: 'default', 'roma', 'infographic', 'macarons', 'vintage', 'shine', 'caravan', 'dark-digerati', 'jazz', and 'london'.")
  }

  return(ifelse(theme == "default",
                "",
                paste(", '",theme,  "'", sep=""))
  )

}

# This is a function defined to help us tackle NA values in data
# In line charts and bar charts, if there is NA values in the data, the function can not work well as Javascript can NOT identify "NA" and it can only identify 'null'.
.process_NA <- function(data){
  data[is.na(data)] <- 'null'
  return(data)
}


# A function designed to help prepare data for heat map

.prepare_data_for_heatmap <- function(dat){
  n_row <- dim(dat)[1]
  n_col <- dim(dat)[2]

  temp <- c()
  for(i in 1:n_row){
    for(j in 1:n_col){
      temp <- c(temp, paste("[", i, ",", j, ",", dat[i,j], "]", sep=""))
    }
  }
  temp <- paste(temp, collapse = ", ")
  temp <- paste("[", temp, "]")
  return(temp)
}



# A function to help check whether these variables who're expected to be logical are logical
.check_logical <- function(x_to_check){
  # 'x_to_check': a list of variable names to check. String format,
  # USAGE: .check_logical(c('var_1', 'var_2', 'var_3'))
  for(x in x_to_check){
    if(is.logical(get(x, envir = parent.frame())) == FALSE){
      stop(paste("Logical variable '", x, "' is not logical. Please check", sep = ""))
    }
  }
}
