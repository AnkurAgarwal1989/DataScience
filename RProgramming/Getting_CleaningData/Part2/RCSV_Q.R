#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("ACS_", today,".csv", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}

library(sqldf)

acs <- read.csv("ACS_2015-08-15.csv")