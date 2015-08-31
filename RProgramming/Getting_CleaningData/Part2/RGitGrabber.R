#Script to read from GitHub API
#uses httr for accessing webAPIs
#Uses jsonlite to deal with JSON data
library(httr)
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "d3b17a5417a32888ba3c",
                   secret = "d0ebec75fe436504f69488478a507fc6cc3529d3") 

#get Credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API 
gtoken <- config(token = github_token) 
req <- GET("https://api.github.com/users/jtleek/repos", gtoken) 
stop_for_status(req) 
data <- content(req) 

#The data can be converted to JSON form
JSONData <- toJSON(data)
#This is data in JSON form. 
#SInce the data had a good structure..we should convert it to a data.frame

df <- fromJSON(JSONData)

#get the repo with name 'datasharing'
repoNum <- which(d$name %in% "datasharing")

d <- d[repoNum,]
d$created_at


