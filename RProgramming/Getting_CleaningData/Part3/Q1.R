#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# download only if not not existing
fileName = "IdahoHousing.csv"
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}

IDHousing = read.csv(fileName)
agr <- (IDHousing$ACR == 3 & IDHousing$AGS == 6)
which(agr)[1:3]

#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
# download only if not not existing
fileName = "img.jpg"
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName, mode = 'wb')
}

img <- readJPEG(fileName, T)

#Q3
#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
# download only if not not existing
fileName = "GDP.csv"
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}
#URL of data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
# download only if not not existing
fileName = "EDU.csv"
if(!file.exists(fileName)){
    download.file(fileUrl, destfile = fileName)
}

GDP <- read.csv("GDP.csv", na.strings = c("NA", "", " "))
EDU <- read.csv("EDU.csv", na.strings = c("NA", "", " "))
GDP <- GDP[!is.na(GDP$X), ]
GDP <- GDP[!is.na(GDP$Gross.domestic.product.2012), ]
combi <- merge(GDP, EDU, by.x = "X", by.y = "CountryCode")
combi$Gross.domestic.product.2012 <- as.numeric(levels(combi$Gross.domestic.product.2012))[combi$Gross.domestic.product.2012]
combi <- combi[order(as.numeric(combi$Gross.domestic.product.2012), decreasing = T), ]
#combi[complete.cases(combi),]
#create a new variable by cutting the GDP into quantiles..we need to give seq 0:1 for 5 divisions
combi$GDPGroups <- cut(combi$Gross.domestic.product.2012, breaks = quantile(combi$Gross.domestic.product.2012, probs = seq(0,1,0.2)))
#Then create a table of gdp vs the income groups column
table(combi$GDPGroups, combi$Gross.domestic.product.2012)

