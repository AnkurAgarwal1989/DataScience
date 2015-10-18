#analysis per cuisine
library(dplyr)
library(reshape2)
library(glmnet)
library(tm)

test <- fromJSON("test.json/test.json")
train <- fromJSON("train.json/train.json")

#read in data by cuisine

# brazilian <- read.csv("dataByCuisine/brazilian.csv", header = T, as.is = T, sep = "$")
# 
# brazilian <- brazilian %>% mutate('Cf_Tf' = as.numeric(Cf)/as.numeric(Tf), 'Cf_Cd' = as.numeric(Cf)/as.numeric(Cd),
#                                   'Tf_Td' = as.numeric(Tf)/as.numeric(Td)) %>% 
#                                       mutate('w' = Cf_Cd*Tf_Td) %>% 
#                                       arrange(desc(Cf_Tf), desc(Cf))
# #find ingredients with Cf/Tf >= 0.2
# brazil_less <- brazilian %>% filter(Cf_Tf >= 0.2)
# 
# brazilTrain <- train
allIng <- unique(unlist(brazilTrain$ingredients))
removeIng <- unique(allIng[!allIng %in% brazil_less$Ingredient])
brazilTrain$cuisineBin <- as.numeric(brazilTrain$cuisine == "brazilian")
brazilTrain$ingredients <- brazilTrain$ingredients#str_replace_all(brazilTrain$ingredients, c(" ", "  "), "")

ingredientsAll <- c(train$ingredients, test$ingredients)
ingredientsAll <- lapply(ingredientsAll, function(x){
    str_replace_all(x, fixed(" "), "")
    str_replace_all(x, "[0-9]*", "")
    str_replace_all(x, "%", "")
    str_replace_all(x, fixed(","), "")
    str_replace_all(x, fixed("(oz.)"), "")
    str_replace_all(x, fixed("(.oz.)"), "")
    #print(as.vector(ing))
    #print(ing)
})
corpusAll <-  Corpus(VectorSource(ingredientsAll))
#corpusAll <- tm_map(corpusAll, removeWords, removeIng[1:2000])
#corpusAll <- tm_map(corpusAll, removeWords, "")
corpusAll <- tm_map(corpusAll, removeNumbers)
corpusAll <- tm_map(corpusAll, removePunctuation)

#corpusAll <- tm_map(corpusAll, stripWhitespace)

AllDTM <- DocumentTermMatrix(corpusAll)
sparseAllDTM <- removeSparseTerms(allDTM, 0.99); #, 0.9999)
trainDTM <- sparseAllDTM[1:nrow(train), ]
testDTM <- sparseAllDTM[(nrow(train)+1 ): (nrow(train)+nrow(test)), ]

model <- cv.glmnet(as.matrix(trainDTM), as.factor(train$cuisine), family = "multinomial")
saveRDS(model, "model.rds")
plot(model)
predictTrain <- predict(model, as.matrix(trainDTM), s= model$lambda.min, type= "class")
