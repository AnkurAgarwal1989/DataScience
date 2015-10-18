library(jsonlite)
library(ggplot2)
library(reshape2)
library(lattice)
setwd("C:/ML_DS/DataScience/Yummly")
train <- fromJSON("train.json/train.json")
train$cuisine <- as.factor(train$cuisine)
byCuisine <- split(train, train$cuisine)
byCuisineIng <- lapply(byCuisine, 
                       function(x) 
                           {sort(table(unlist(x$ingredients)), decreasing = T)[1:10]})


byCuisineDF <- as.data.frame(unlist(byCuisineIng))
cuisine.ing <- strsplit(rownames(byCuisineDF), ".", fixed = T)
byCuisineDF$cuisine <- sapply(cuisine.ing, '[[', 1)
byCuisineDF$ing <- sapply(cuisine.ing, '[[', 2)
rownames(byCuisineDF) <- seq(length=nrow(byCuisineDF))
byCuisineDF$cuisine <- as.factor(byCuisineDF$cuisine)
tapply(byCuisineDF, byCuisineDF$cuisine, 
       function(x) {barplot(byCuisineDF$ing, byCuisineDF$`unlist(byCuisineIng)`)})

g <- ggplot(data = byCuisineDF, aes(x=ing, y='unlist(byCuisineIng)'), group=cuisine)
g + geom_bar(stat = "identity") + facet_wrap(~cuisine) + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
png("IngBycuisine.png", 2000, 1500)
par(mfrow=c(2,10))
#for plotting
cuisineList <- as.list(unique(byCuisineDF$cuisine)[1:20])
sapply(cuisineList, function(x) {
    d <- byCuisineDF[byCuisineDF$cuisine == x, ];
    barplot(names.arg = as.factor(d$ing), height = d$`unlist(byCuisineIng)`, main = x, las=2);
})
dev.off()

