rankall <- function(outcome, num = "best") { 
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    reqColumn <- NULL
    
    ## Check that state and outcome are valid
    #list to map col name to column number
    outcomeMap <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    
    #validating 'outcome'...see if it exists in the list we have
    if (is.null(outcomeMap[[outcome]])){
        stop("invalid outcome")
    }
    else{
        reqColumn <- outcomeMap[[outcome]]
    }
    
    #reduce df size to just required fields
    df <- df[, c(2, 7, reqColumn)]
    
    #convert number col from char
    df[,3] <- as.numeric(df[,3])
    df <- df[complete.cases(df), ]
    
    ## For each state, find the hospital of the given rank
    #split the df into mulitple dfs by states. Then we can use lapply to do the sorting operatn
    list_states <- split(df, df$State)

    orderedListByState <- lapply(list_states, 
                                 function(x) {x[order(x[, 3], x[, 1]), ] });
    
    
    ranksByState <- lapply(orderedListByState, function(x) {
        
        if (num == "best"){
            x <- x[1,c(1,2)];
        }
        
        else if (num == "worst"){
            x<- x[nrow(x),c(1,2)];
        }
        
        else if (nrow(x) < num){
            x <- x[1, c(1,2)];
            x[1,1] <- "NA";
        }
        else {
            x <- x[num,c(1,2)];
        }
    })
    
    ranksByState <- do.call(rbind.data.frame, ranksByState) 
    colnames(ranksByState) <- c("hospital", "state")
    return (ranksByState)
    
    
    ## Return a data frame with the hospital names and the ## (abbreviated) state name
}
