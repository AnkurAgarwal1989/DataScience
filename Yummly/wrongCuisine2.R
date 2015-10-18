library(stringr)


l <- train$ingredients[1:3]
d <- lapply(l, function(x){
    str_replace_all(x, fixed(" "), "")
    #print(as.vector(ing))
    #print(ing)
})

#as.vector(as.character(levels(train$cuisine)))


lapply(d2, FUN = function(x) {
    write(x, append = T, file = "ingredientsbyDish.txt", ncolumns = length(x))
})


d2$cuisine <- train$ingredients[train$id %in% d2$train.id]

d2 <- arrange(d2, as.character(d2$train.cuisine), as.character(d2$predictTrain...2.))
djson <- toJSON(d2)
write(djson, "djson.json", sep = "\t", ncolumns = 4)

write.csv(d2[, c(1:3)], file = "wrongCuisines.csv", quote = F, row.names = F)