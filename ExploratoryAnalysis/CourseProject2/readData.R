library(dplyr)

setwd("C:/ML_DS/DataScience/ExploratoryAnalysis/CourseProject2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_tbl <- tbl_df(NEI) 

pollByYear <- NEI %>% group_by(year) %>% summarise(sum(Emissions))
plot(pollByYear, type = 'l', ylab = "Total Emissions (tons)", xaxt = 'n', lwd = 3,
     main = "Total Emission over years")
axis(1, at = seq(1999, 2008, 1), las = 2)
dev.copy(png, "TotalEmission_Year.png")
dev.off()

barplot(height = pollByYear$`sum(Emissions)`, width = pollByYear$year)
plot(NEI$Emissions[NEI$year==1999], type = 'o')
lines(NEI$Emissions[NEI$year==2002],type = 'o', col ='red')
lines(NEI$Emissions[NEI$year==2005],type = 'o', col = 'green')
lines(NEI$Emissions[NEI$year==2008],type = 'o', col = 'blue')

pollMaryland <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarise(sum(Emissions))
plot(pollMaryland, type = 'l', ylab = "Total Emissions (tons)", xaxt = 'n', lwd = 3,
     main = "Total Emission in Maryland over years")
axis(1, at = seq(1999, 2008, 1), las = 2)
dev.copy(png, "TotalEmission_Maryland.png")
dev.off()