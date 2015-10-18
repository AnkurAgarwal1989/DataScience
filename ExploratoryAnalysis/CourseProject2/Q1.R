library(dplyr)
library(lattice)
library(ggplot2)

pollByYear <- NEI %>% group_by(year) %>% summarise(sum(Emissions))
yLabel = "Total Emissions (tons)"
xLabel = "Years"
mainTitle = "Total Emission over years"

#Base plotting system
png("plot1.png")
plot(x = pollByYear, type = 'l', lwd = 3,
     ylab = yLabel, xaxt = 'n',
     main = mainTitle)
axis(1, at = seq(1999, 2008, 1), las = 2)
#dev.copy(png, "TotalEmission_Year.png")
dev.off()
#dev.off(dev.prev())


#Lattice Plotting system
xyplot(data=pollByYear, pollByYear$`sum(Emissions)` ~ pollByYear$year, typ='l', lwd = 3,
       xlab = xLabel, ylab = yLabel,
       main = mainTitle)
dev.copy(png, "TotalEmission_Year_Lattice.png")
dev.off()
#dev.off(dev.prev())


##GGPlot_qplot
qplot(data=pollByYear, x= pollByYear$year, y = pollByYear$`sum(Emissions)`,
      geom = "line", xlab = xLabel, ylab = yLabel,
      main = mainTitle)
dev.copy(png, "TotalEmission_Year_qplot.png")
dev.off()


##GGplot
g <- ggplot(data = pollByYear, aes(x= pollByYear$year, y=pollByYear$`sum(Emissions)`))
g + geom_line(size = 2) + 
    labs(x = xLabel, y= yLabel, title = mainTitle)
dev.copy(png, "TotalEmission_Year_ggplot.png")
dev.off()
#dev.off(dev.prev())

