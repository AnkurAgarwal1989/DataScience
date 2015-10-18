library(jsonlite)
library(tm)
library(glmnet)

test <- fromJSON("test.json/test.json")
train <- fromJSON("train.json/train.json")

train$cuisine <- as.factor(train$cuisine)

write.csv(sort(unique(unlist(test$ingredients))), "testIng.txt")


write.csv(sort(unique(unlist(train$ingredients))), "trainIng.txt")

testIng <- sort(unique(unlist(test$ingredients)))

trainIng <- sort(unique(unlist(train$ingredients)))
ingBagOfWords <- intersect(testIng, trainIng)
write.csv(ingBagOfWords, "intersect.txt")

#create a corpus from training data
ingredientsAll <- c(train$ingredients, test$ingredients)
#corpusAll <-  Corpus(VectorSource(ingredientsAll), readerControl = as.list(ingBagOfWords))
corpusAll <-  Corpus(VectorSource(ingredientsAll))
allDTM <- DocumentTermMatrix(corpusAll, control = list(weighting = function(x) weightSMART(x, spec = "ltc", normalize = TRUE)))
sparseAllDTM <- removeSparseTerms(allDTM, 0.99)

trainDTM <- sparseAllDTM[1:nrow(train), ]
testDTM <- sparseAllDTM[(nrow(train)+1 ): (nrow(train)+nrow(test)), ]

cvmodel <- cv.glmnet(as.matrix(trainDTM), train$cuisine, family = "multinomial")

# trainCorpus <- Corpus(VectorSource(train$ingredients))
# trainDTM <- DocumentTermMatrix(trainCorpus, as.list(ingBagOfWords))
# sparsetrainDTM <- removeSparseTerms(trainDTM, 0.99)
# model <- glmnet(as.matrix(trainDTM), train$cuisine, family = "multinomial")
# testCorpus <- Corpus(VectorSource(test$ingredients))
# testDTM <- DocumentTermMatrix(testCorpus, as.list(ingBagOfWords))
# sparsetestDTM <- removeSparseTerms(testDTM, 0.99)

allTrainResults <-predict(model, newx = as.matrix(trainDTM), type="class")

results <-predict(model, newx = as.matrix(testDTM), type="class", s = 0.001)
submission <- data.frame(id = test$id, cuisine = as.matrix(results)[,1])
write.csv(submission, "submission.csv", row.names = F, quote = F)

resTrain <- data.frame(id = train$id, cuisine = as.matrix(resultsTrain)[,1])
train$cuisine[which(!resTrain$cuisine == train$cuisine)]
resultsTrain <-predict(model, newx = as.matrix(trainDTM), type="class"), s = 0.001 )


