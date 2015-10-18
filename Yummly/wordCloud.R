#word cloud of ingredients
library(tm)
library(wordcloud)
library(SnowballC)
#ingredientData has full names of ings with spaces..we wanna remove all that stuff
ingredients <- Corpus(VectorSource(ingredientData[,2]))
ingredients <- tm_map(ingredients, removeWords, stopwords("english"))
ingredients <- tm_map(ingredients, stemDocument)

ingDF <- data.frame(text=unlist(sapply(ingredients, `[`, "content")), 
                               stringsAsFactors=F)

wordcloud(ingredientData[,2], ingredientData[,1], scale=c(5,0.5), max.words=100, random.order=FALSE, 
          rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))


ingredients[1]