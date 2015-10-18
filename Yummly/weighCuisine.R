#Analyse model and see if we can weigh different cuisines
model <- readRDS("model.rds")
prediction <- predict(model, as.matrix(trainDTM), s= model$lambda.min, type= "response")

