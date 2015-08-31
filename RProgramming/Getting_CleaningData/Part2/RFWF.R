#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("CPC_", today,".for", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}
