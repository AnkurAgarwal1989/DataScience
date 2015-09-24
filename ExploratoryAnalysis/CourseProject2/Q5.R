#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 
library(dplyr)
library(ggplot2)
motorVehicleSources <- levels(SCC$EI.Sector)[grep("Mobile - On-Road", levels(SCC$EI.Sector), ignore.case = T)]

motorVehicleSources_SCC <- SCC[SCC$EI.Sector %in% motorVehicleSources, 1]

motorVehPoll <- NEI %>% 
    filter(SCC %in% motorVehicleSources_SCC, (fips == "24510" | fips == "06037")) %>%
    group_by(fips, year) %>%
    mutate(sumEm = sum(Emissions))

motorVehPollpn <- merge(motorVehPoll, SCC[, c('SCC', 'Short.Name', 'EI.Sector')], by.x = "SCC", by.y = "SCC", all.x = T, all.y = F, )

motorVehPoll_baltimore = motorVehPoll[motorVehPoll$fips == "24510", ]
motorVehPoll_baltimore$year = as.factor(motorVehPoll_baltimore$year)
motorVehPoll_baltimore <- motorVehPoll_baltimore %>% 
    group_by(year) %>% 
    summarise(sumEm = sum(Emissions))

png("plot5.png", 480, 480);
g <- ggplot(data = motorVehPoll_baltimore, aes(y=sumEm, x=year)) + geom_bar(stat = "identity")
#g <- ggplot(data = motorVehPoll_baltimore, aes(y=type, x=year)) 
g + ggtitle("Pollution in Baltimore City") + labs(x="Year", y="Sum of Pollution")
#g + geom_point(aes(size=motorVehPoll_baltimore$sumEm))
dev.off()