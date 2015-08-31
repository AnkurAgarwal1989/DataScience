library(plyr) 

files <- dir("raw", full = T) 
names(files) <- gsub("\\.csv", "", dir("raw")) 
bnames <- ldply(files, read.csv, header = F,stringsAsFactors  = F) 
