if(!file.exists("cameras.csv")){
    fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
    download.file(fileUrl, "cameras.csv")
    }
cameraData <- read.csv("cameras.csv")
names(cameraData)

#Some column names have a '.' in them...we wanna remove that dot
#so first we split and then we'll just keep the first element after split
splitNames <- strsplit(names(cameraData), "\\.")
splitNames
firstPart <- function(x){x[1]}
splitNames <- sapply(splitNames, firstPart)
splitNames