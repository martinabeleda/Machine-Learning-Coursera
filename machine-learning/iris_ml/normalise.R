# Normalise function
# usage: YourNormalisedDataSet <- as.data.frame(lapply(YourDataSet, normalise))
normalise <- function(x) {
    num <- x - min(x)
    denom <- max(x) - min(x)
    return(num/denom)
}

