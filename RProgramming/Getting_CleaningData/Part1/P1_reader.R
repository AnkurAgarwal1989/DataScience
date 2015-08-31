#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("housingSurvey_", today,".csv", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}


#URL of codebook
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("hs_Codebook_", today,".pdf", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    #for some reason pdf download needs mode=wb
    download.file(fileUrl, destfile = fileName, mode="wb")
}

#URL of xls
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("NGAP_", today,".xlsx", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    #for some reason pdf download needs mode=wb
    download.file(fileUrl, destfile = fileName,mode="wb")
}
 
#URL of xml
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("restaurants_", today,".xml", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    #for some reason pdf download needs mode=wb
    download.file(fileUrl, destfile = fileName,mode="wb")
}

 
#URL of xml
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
#Timestamping w/ today's date
today <- Sys.Date()
format(today, format="%B_%d_%Y")
fileName <- paste("survey_", today,".csv", sep = "")
# download only if not not existing
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}
