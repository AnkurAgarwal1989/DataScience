rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    reqColumn <- NULL
    
    #list to map col name to column number
    outcomeMap <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    
    #Vector of uniue state names....so we can validate our entry
    states = unique(df$State)
    
    ## Check that state and outcome are valid
    #we cul dalso use match instead of %in%
    if (!(state %in% states)){
      stop("invalid state")
    }
    
    #validating 'outcome'...see if it exists in the list we have
    if (is.null(outcomeMap[[outcome]])){
      stop("invalid outcome")
    }
    else{
      reqColumn <- outcomeMap[[outcome]]
    }
    
    
    #reduce df size to just required fields
    df <- df[, c(2, 7, reqColumn)]
    
    #we just need one particular state..so get only those rows
    # now 3 cols, 1 2 3,....2 is state now
    df <- df[ df[,2] == state, ]
    
    #order by reColumn first...also give second ordering as hospital name (for ties)
    df[,3] <- as.numeric(df[,3])
    df <- df[complete.cases(df), ]
    df <- df[order(as.numeric(df[,3]),df[, 1]), ]
   
    if (num == "best"){
      num <- 1;
    }
    if (num == "worst"){
      num <- nrow(df);
    }
    
    if (nrow(df) < num)
      return(NA)
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    df[num,1]
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
}
