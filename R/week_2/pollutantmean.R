pollutantmean <- function(directory, pollutant, id=1:332) {
  ## remember orignal location
  ## we will restore it after function is finished
  old_dir <- getwd()
  
  ## go to location where data files are
  setwd(directory)
  
  # we want NULL as a marker that we don't have data yet
  data <- NULL
  
  # iterate over all the files we want to read
  # convert values to file names, and read data
  # rbind will allow us to concatenate everything
  for(i in id) {
    # create file name
    fname <- sprintf("%03d.csv", i)
    
    # NULL means that we are reading first file from the list
    if(is.null(data)) {
      data <- read.csv(fname, header = TRUE)
    } else {
      data <- rbind(data, read.csv(fname, header = TRUE))
    }
  }
  
  # remove missing values
  cleaned_data <- data[pollutant][!is.na(data[pollutant])]
  
  # calculate mean value
  ret_mean <- mean(cleaned_data)
  
  # go to location where we have started from
  setwd(old_dir)
  
  # return result
  ret_mean
}