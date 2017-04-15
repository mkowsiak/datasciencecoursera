corr <- function(directory, threshold = 0) {
  ## remember orignal location
  ## we will restore it after function is finished
  old_dir <- getwd()
  
  ## go to location where data files are
  setwd(directory)
  
  # we want NULL as a marker that we don't have data yet
  result <- NULL
  
  # iterate over all the files we want to read
  # convert values to file names, and read data
  # rbind will allow us to concatenate everything
  for(i in 1:332) {
    # create file namem
    fname <- sprintf("%03d.csv", i)
    
    data <- read.csv(fname, header = TRUE)
    clean_data <- data[complete.cases(data),]
    if(nrow(clean_data) >= threshold) {
      cor_res <- cor(x=clean_data["sulfate"], y=clean_data["nitrate"])
      if(is.null(result)) {
        result <- as.vector(cor_res)
      } else {
        result <- rbind(result, as.vector(cor_res))
      }
    }
  }
  if(is.null(result)) {
    result <- vector('numeric')
  } else {
    result <- as.vector(result)
  }

  # go to location where we have started from
  setwd(old_dir)
  
  # return result
  result
}