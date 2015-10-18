#wrong cuisine analysis
library(dplyr)
library(ggplot2)
library(RColorBrewer)
wrongCuisine <- read.csv("wrongCuisines.csv")
wrongPairs <- wrongCuisine %>% group_by(train.cuisine) %>% summarise_each(funs(length))
wrongPairs <- distinct(wrongCuisine[, c(2,3)]) 

wrongP <- wrongCuisine[, c(2,3)]
names(wrongP) <- c("c1", "c2")

wrongP_byGroup <- wrongP %>% group_by(c1, c2) %>% summarise(countWrongPairs = n()) %>%
    arrange(desc(countWrongPairs))

wrongP_byWrongPair <- wrongP_byGroup %>% ungroup %>% arrange(desc(countWrongPairs))

wrongP_byGroup$c1 <-as.factor(wrongP_byGroup$c1)
wrongP_byGroup$c2 <-as.factor(wrongP_byGroup$c2)

png("WrongCuisines.png", 1080, 720)
g <- ggplot(data = wrongP_byGroup, aes(y = countWrongPairs))

colourCount = length(unique(wrongP_byGroup$c2))
getPalette = colorRampPalette(brewer.pal(9, "Paired"))


g + geom_bar(aes(x = c2, fill = c2), stat = "identity" ) + facet_wrap(~ c1) +
    theme(axis.text.x=element_blank()) + labs(x = "Wrong Prediction") + 
    scale_fill_manual(values = getPalette(n = colourCount)) +
    theme(legend.position="bottom") +
    guides(fill=guide_legend(nrow=2, title = "Wrong Prediction"))

dev.off()
    