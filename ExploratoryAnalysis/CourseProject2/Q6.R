#use ddply to aply a function to each subset
#subset database by type, the we find the diff betweeb sum of emissions 
library(plyr)
library(ggplot2)
d <- ddply(motorVehPoll, 
           .(fips),  
           summarize,
           mu = mean(sumEm),
           s = sd(sumEm))

motorVehPoll2 = merge(motorVehPoll, d, by = "fips")

motorVehPoll2$weightedPollution = (motorVehPoll2$sumEm - motorVehPoll2$mu)/motorVehPoll2$s;
#year = head(year,-1), 
#change = diff(sumEm))

#tabulate it to view easily
xtabs(data=motorVehPoll2, weightedPollution ~ (motorVehPoll2$year +motorVehPoll2$fips))
motorVehPoll2$year = as.factor(motorVehPoll2$year)
motorVehPoll2$type = as.factor(motorVehPoll2$type)

png("plot6.png", 480, 480);
g <- ggplot(data = motorVehPoll2, aes(x= year, y= weightedPollution, color = fips, group = fips)) + 
    ggtitle("Weighted pollution in cities during a year")
g <- g + geom_point(size = 6) + geom_line()
g + scale_color_discrete(name="Cities", labels = c("Los Angeles", "Baltimore"))
dev.off()
