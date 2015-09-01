housing <- read.csv("housingSurvey_2015-08-24.csv")
housingNames <- names(housing)
a <- strsplit(housingNames, split = "wgtp")


gdp <- read.csv("GDP.csv", na.strings = c(""," "))
rankedgdp <- gdp[which(!is.na(gdp$Gross.domestic.product.2012)), ]
money <- rankedgdp$X.3
money <- gsub(",", "", money)
money <- as.numeric(money)
mean(money, na.rm = T)

countryNames <- gdp$X.2
length(grep("^United", countryNames))

edu <- read.csv("EDU.csv", na.strings = c(""," "))
merged <- merge(rankedgdp, edu, by.x = "X", by.y = "CountryCode")
juneend <- grep("[fF]iscal", merged$Special.Notes, value = T)
juneend <- grep("[jJ]une", juneend, value = T)
length(juneend)

