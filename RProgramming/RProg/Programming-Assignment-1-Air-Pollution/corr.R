corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  allObservations <- complete(directory);
  ##which gives the indices of true locations
  completeOverThresh<- which(allObservations$nobs >= threshold);
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  listOfFiles <- list.files(directory, full.names = TRUE);
  tmp <- lapply(listOfFiles[completeOverThresh], read.csv);
  tmp <- lapply(tmp, function(x) {x[complete.cases(x), ]});
  
  corr <- sapply(tmp, function(x) {cor(x$nitrate,x$sulfate)});
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
}
