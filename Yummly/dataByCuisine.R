#script to split the train data into multiple files
#each file will be named "<cuisine>.csv"str_replace_all(names(Cf), c(" ", "  "), "")
#will contain ingredient name, freq in cuisine, 
#total dishes in cuisine, freq in all data, total dishes 
setwd("C:/ML_DS/DataScience/Yummly")

library(jsonlite)
library(tm)
library(SnowballC)
library(stringr)

train <- fromJSON("train.json/train.json")
train$cuisine <- as.factor(train$cuisine)

#total dishes
Td <- nrow(train)
#generate frequency data for all possible ingredients
Tf <- table(unlist(train$ingredients))

#train2 <- train[1:10, ]
byCuisine <- split(train, train$cuisine, drop = T)
byCuisineIng <- lapply(byCuisine, 
                       function(x) {
                           #calculate cuisine frequency for each ing in cuisine
                           print(as.character(unique(x$cuisine)))
                           Cf <- table(unlist(x$ingredients))
                           Cd <- nrow(x)
                           
                           ing <- data.frame(names(Cf), as.vector(Cf), as.vector(rep(Cd, length(Cf))), as.vector(Tf[names(Cf)]), as.vector(rep(Td, length(Cf))))
                           
                           names(ing) <- c("Ingredient", "Cf", "Cd", "Tf", "Td")
                           write.table(ing, paste("dataByCuisine/", as.character(unique(x$cuisine)), ".csv", sep = ""), 
                                     quote = F, row.names = F, sep = "$")
                           })