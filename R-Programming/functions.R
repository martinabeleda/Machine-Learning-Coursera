add2 <- function(x, y) {
  x + y
}

above10 <- function(x) {
    
    use <- x > 10
    x[use]
}

above <- function(x, n = 10) {
    
    use <- x > n
    x[n]
}

columnMean <- function(matrix, removeNA = TRUE) {
    
    nc <- ncol(matrix)
    means <- numeric(nc)
    for(i in 1:nc) {
        means[i] <- mean(matrix[, i], na.rm = removeNA)
        
    }
    means
}