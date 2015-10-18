setwd("C:/ML_DS/DataScience/Yummly")
library(jsonlite)

train <- fromJSON("train.json/train.json")
ing <- train$ingredients;
train$cnt <- sapply(ing, length);
ing <- unlist(ing);

ingrdientList<- sort(table(unlist(ing)), decreasing = T)

ingredientData <- data.frame(as.vector(ingrdientList), as.character(names(ingrdientList)))
names(ingredientData) <- c("cnt", "ing")

top10 <- ingredientData[1:10, ]

#top10 <- top10[,c(1,3)]

library(ggplot2)
g <- ggplot(data = top10, aes(x = ing, y=cnt)) + geom_point(stat = "identity")
g + theme(axis.text.x=element_text(angle=90))

#we need to tell ggplot that the x axis is already ordered.
#else it tries to order it
top10$ing2 <- factor(top10$ing, as.character(top10$ing))
g <- ggplot(data = top10, aes(x = ing2, y=cnt)) + geom_point(stat = "identity")
g + theme(axis.text.x=element_text(angle=90))


#Italian recipes account for 20% of the recipes
barplot(sort(table(train$cuisine), decreasing = T), las = 3)
prop.table(sort(table(train$cuisine), decreasing = T)) * 100

#recipes with most ingredients
library(dplyr)
train_byCnt <- arrange(train, desc(cnt))
plot(density(train_byCnt$cnt))
hist(train_byCnt$cnt, breaks = 60)
rug(train_byCnt$cnt)
#most recipes are between 5-15 ingredients


