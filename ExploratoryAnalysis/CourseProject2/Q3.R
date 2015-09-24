#3.Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008
#for Baltimore City? Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

pollMarylandAll <- NEI %>% 
    select(fips, Emissions, type, year) %>%
    filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarise(sumEm = sum(Emissions))
pollMarylandAll$year = as.factor(pollMarylandAll$year)
#qplot
qplot(data=pollMarylandAll, geom = c("point", "smooth"), 
      margins = T, y=sumEm, x= year, color = type) + geom_smooth(size=1)

##ggplot
g1 <- ggplot(data=pollMarylandAll, aes(y=sumEm, x= year, color = type))
g1 + geom_point(size=3) + geom_smooth()

g2 <- ggplot(data=pollMarylandAll, aes(y=sumEm, x= year, color = type))
g2 + geom_point(size=3) + geom_smooth(method = lm) + facet_grid(~type) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))