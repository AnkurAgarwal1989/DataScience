pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  #Get the entire list of files in directory
  listOfFiles <- list.files(directory, full.names = TRUE);
  
  # Use only id files
  #Use lapply to read csv files
  tmp <- lapply(listOfFiles[id], read.csv);
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  # We need only the 'pollutant" required...so take them out in a vector
  out <- lapply(tmp, function(x) {x[,pollutant]})
  
  allidPollutant <- do.call(c, out);
  return(mean(allidPollutant, na.rm = TRUE));
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
}
