readDataFunc <- function(){
    library(sqldf)
    require(sqldf)
    
    ##Read the data from originla file if the smaller file has not been created..even once
    if( file.exists("requiredData.csv")){
        requiredData <- read.csv("requiredData.csv", na.strings = c('?', 'NA'), header = T);
    }
    
    #else read the fresh original data and also save out the required chunk
    # we are not gonna read the entire data
    else {
    requiredData <- read.csv2.sql("household_power_consumption.txt", sql = "SELECT * FROM file WHERE Date in ('1/2/2007', '2/2/2007')")
    write.csv(requiredData, "requiredData.csv")
    }
    
    #Putting the dates together
    requiredData$Date <- as.character.Date(requiredData$Date)
    requiredData$Time <- as.character.Date(requiredData$Time)
    requiredData$DateTime <- paste(requiredData$Date, requiredData$Time)
    requiredData$DateTime <- strptime(requiredData$DateTime, "%d/%m/%Y %H:%M:%S")
    return(requiredData);
}
