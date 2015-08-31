complete <- function(directory, id = 1:332) {
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  listOfFiles <- list.files(directory, full.names = TRUE);
  tmp <- lapply(listOfFiles[id], read.csv)
  
  #sum willl sum up all trues...so we get all good cases
  nobs <- sapply(tmp, function(f) {sum(complete.cases(f))});
  
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  complete <- data.frame(id, nobs);
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
}
