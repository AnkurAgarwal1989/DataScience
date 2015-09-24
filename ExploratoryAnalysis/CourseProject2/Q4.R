# 4.Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
# 

library(ggplot2)
library(dplyr)
# to find coal combustion related sources, we need to find where coal/ combustion occurs in
# the data
#

head(SCC)
comb <- grep("comb", SCC$EI.Sector, ignore.case = T);
coal <- grep("coal", SCC$EI.Sector, ignore.case = T);
coal_comb1 <- intersect(comb, coal)

comb <- grep("comb", SCC$Short.Name, ignore.case = T)
coal <- grep("coal", SCC$Short.Name, ignore.case = T)
coal_comb2 <- intersect(comb, coal)

coal_comb <- sort(union(coal_comb1, coal_comb2))

coal_combSCC <- SCC$SCC[coal_comb]
coal_combSCC <- as.character(coal_combSCC)

reqdNEI <- NEI[NEI$SCC %in% coal_combSCC, ]
write.csv(reqdNEI, "coalCombustionSources.csv")

reqdNEI <- read.csv('coalCombustionSources.csv')

reqdNEI <- reqdNEI %>%
    group_by(year, type) %>%
    summarise(sumEm = sum(Emissions))
png("plot4.png", 480, 480);
g <- ggplot(data = reqdNEI, aes(y = sumEm, x = year, fill = type)) + geom_bar(stat = "identity", position="dodge")
g + scale_fill_discrete(name="Pollutant Type")
dev.off()