## Functions for caching matrix inversion
#makeCacheMatrix: This function creates a special "matrix" object
#that can cache its inverse.
#cacheSolve: This function computes the inverse of the special "matrix" 
#returned by makeCacheMatrix above. If the inverse has already been calculated
#(and the matrix has not changed), then the cachesolve should retrieve the inverse
#from the cache.

## Function to create a caching object
# this esentially is a list of functions 
# that set and get a matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
    #Init inverse to null
    inverse <- NULL
    
    set <- function(y){
        #Use << to assign value to the already existing object
        x <<- y
        inverse <<- NULL
    }
    
    get <- function(){
        x
    }
    
    setInv <- function(y){
        inverse <<- y
    }
    
    getInv <- function(){
        inverse
    }
    
    list(set = set, get = get, setInv = setInv, getInv = getInv)
    
}


## Function to calculate inverse of matrix, if not calculated before

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    # Check if an inverse already exists...
    # if no...calculate and set
    
    if (is.null(x$getInv())){
        message("Calculating inverse...")
        x$setInv(solve(x$get()));
    }
    
    #output the inverse
    return(x$getInv())
    
    
}
