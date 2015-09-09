readDataFunc <- function(){
    
    ##Read the data from originla file if the smaller file has not been created..even once
    if( file.exists("requiredData.csv")){
        requiredData <- read.csv("requiredData.csv", na.strings = c('?', 'NA'), header = T);
        return(requiredData);
    }
    
    #else read the fresh original data and also save it out 
    else {
    #Read only 1st column of the database. This column has all dates.
    dataDates <- read.table("household_power_consumption.txt", sep = ';', na.strings = '?', 
                            header = T, as.is = T, colClasses = c("character", rep("NULL", 8)))
    
    # we only need a small date range...find row indices with these dates
    requiredDates <- which(dataDates$Date %in% c("1/2/2007", "2/2/2007"))
    
    #Now read just 1 or 2 lines to get the classes of the data. This makes for faster reading later on. 
    sampleData <- read.table("household_power_consumption.txt", sep = ';', na.strings = '?', nrows = 2,
                             header = T)
    #Classes
    classes <- sapply(sampleData, class)
    #Extract data names so that we don't need to read it again and again
    dataNames <- names(sampleData)
    
    #Now loop over the vector of indices and read one required row at a time.
    #the indices show which row to skip to
    d <- lapply(reqdDates, 
                function(x){read.table("household_power_consumption.txt", sep = ';',
                                       na.strings = '?',nrows = 1, header = F, as.is = T,
                                       skip = x, colClasses = classes, comment.char = "")})
    # a new data frame to put all data
    requiredData <- data.frame()
    #bind the list of dfs into 1 data frame
    requiredData <- do.call(rbind, d);
    #name the columns
    names(df)<-dataNames
    #write it out to a file so we don't need to run this again and again.
    write.csv(df, "requiredData.csv")
    return(requiredData);
    }
}
