## Matrix Inversion w/ Caching
## Author: Martin Abeleda
## Date: 22/12/2016
## 
## Brief: Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather 
## a matrix rather than computing it repeatedly. These pair of functions are used to cache the inverse of a matrix
##
## Usage:
# > matrix <- rbind(c(1, 4), c(3, 9))
# > mat = makeCacheMatrix(matrix)
# > cacheSolve(mat)
# [,1]       [,2]
# [1,]   -3  1.3333333
# [2,]    1 -0.3333333

## makeCacheMatrix()
## This function creates a special "matrix" object that can cache its inverse which is really a list containing a function to
# 1. set the value of the vector
# 2. get the value of the vector
# 3. set the value of the mean
# 4. get the value of the mean

makeCacheMatrix <- function(x = matrix()) {
    
    # Initialise the cache as empty
    inv <- NULL
    
    # 
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    
    # Get the matrix
    get <- function() x
    
    # Write to the cache
    setinv <- function(inverse) inv <<- inverse
    
    # Return the cache
    getinv <- function() inv
    
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
    
}

## cacheSolve()
## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
#  If the inverse has already been calculated (and the matrix has not changed), 
#  then cacheSolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
    
    inv <- x$getinv()
    
    # If there is a value stored in the cache
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    
    # If the cache is empty
    data <- x$get()
    
    # Calculate the inverse
    inv <- solve(data)
    
    # Store in the cache
    x$setinv(inv)
    
    # Return the inverse
    inv
}
