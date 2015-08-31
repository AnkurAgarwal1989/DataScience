# housing <- read.csv("housingSurvey_2015-08-11.csv")
# 
# #Houses with value > 1,000,000
# #from code book...this is VAL = 24
# #we'll need to discount NAs
# val24 <- sum(housing$VAL==24 & !is.na(housing$VAL))
# print(val24)
# reqCols = 7:15
# reqRows = 18:23
# dat <- read.xlsx("NGAP_2015-08-11.xlsx", sheetIndex = 1, rowIndex = reqRows, colIndex = reqCols)
# str(dat)
# print(sum(dat$Zip*dat$Ext,na.rm=T))

# restaurants <- xmlTreeParse("restaurants_2015-08-11.xml", useInternalNodes = TRUE)
# rootNode <- xmlRoot(restaurants)
# zips <- xpathSApply(rootNode, path = "//zipcode", xmlValue)
zi <- as.numeric(zi)
sum(zi == 21231)

DT <- fread("survey_2015-08-11.csv")