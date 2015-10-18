#Classification with SVM
library(e1071)
library(jsonlite)
library(tm)
library(glmnet)
library(stringr)
library(SparseM)
setwd("C:/ML_DS/DataScience/Yummly")
test <- fromJSON("test.json/test.json")
train <- fromJSON("train.json/train.json")

train$cuisine <- as.factor(train$cuisine)

ingredientsAll <- c(train$ingredients, test$ingredients)
ingredientsAll <- lapply(ingredientsAll, function(x){
    x <- gsub(pattern = "\\s+", x = x, replacement = "")
    x <- str_replace_all(x, fixed(" "), "")
    x <- str_replace_all(x, "%", "")
    x <- str_replace_all(x, "[0-9]*", "")
    x <- str_replace_all(x, "\\(", "")
    x <- str_replace_all(x, "\\)", "")
    x <- str_replace_all(x, fixed(","), "")
    x <- str_replace_all(x, fixed("."), "")
    x <- str_replace_all(x, fixed("oz"), "")
    #x<-list(x)
    #print(as.vector(ing))
    #print(ing)
})

corpusAll <-  Corpus(VectorSource(ingredientsAll))
#corpusAll <- tm_map(corpusAll, removeWords, c("\\(10","\\(14","\\(14.5","\\(15","\\(flour\\)","\\(not","\\(powder\\)","1/2","100","100\\%","25\\%","33%","40%","50%","95\\%","96%"))
allDTM <- DocumentTermMatrix(corpusAll)
#Not removing sparse terms for SVM 
#sparseAllDTM <- removeSparseTerms(allDTM, 0.99)

trainDTM <- allDTM[1:nrow(train), ]
testDTM <- allDTM[(nrow(train)+1 ): (nrow(train)+nrow(test)), ]

wts <- 100/ table(train$cuisine)
model <- svm(y = train$cuisine, x = trainDTM, class.weights = wts)
