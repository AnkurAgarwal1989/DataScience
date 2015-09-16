library(dplyr)
library(lattice)
library(ggplot2)

pollMaryland <- NEI %>% 
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarise(sum(Emissions))

yLabel = "Total Emissions (tons)"
xLabel = "Years"
mainTitle = "Total Emission in Maryland over years"

## Base plot
plot(pollMaryland, type = 'l', ylab = "Total Emissions (tons)", xaxt = 'n', lwd = 3,
     main = "Total Emission in Maryland over years")
axis(1, at = seq(1999, 2008, 1), las = 2)
dev.copy(png, "TotalEmission_Maryland_Base.png")
dev.off(which = dev.cur())

##gplot
##GGplot
g <- ggplot(data = pollMaryland, aes(x= pollMaryland$year, y=pollMaryland$`sum(Emissions)`))
g + geom_line(size = 2) + 
    labs(x = xLabel, y= yLabel, title = mainTitle)
dev.copy(png, "TotalEmission_Maryland_ggplot.png")
dev.off(which = dev.cur())