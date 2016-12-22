## Complete
## Author: Martin Abeleda
## Date: 22/12/2016
##
## Usage:
#  > source("complete.R")
#  > complete("specdata", 1)
#    id nobs
#    1  1  117

## complete()
## This function returns a data frame containing the number of complete observations in each id
#  Params:
#       directory - a character vector indicating the directory of the CSV files.
#       id        - an integer vector indicating the monitor ID numbers to be used.
#  Return:
#       A data frame containing the 'nobs' for each given 'id'.

complete <- function(directory, id = 1:332) {
    
    ## Create a vector of filenames
    filenames <- vector(mode = "character", length = length(id))
    
    # Construct a vector of the different file names
    for (i in 1:length(id)) {
        num <- id[i]
        
        if (num >=0 && num <= 9) {
            file <- paste(directory, "/00", as.character(num), ".csv", sep = "")
        }
        else if (num >= 10 && num <= 99) {
            file <- paste(directory, "/0", as.character(num), ".csv", sep = "")
        }
        else {
            file <- paste(directory, "/", as.character(num), ".csv", sep = "")
        }
        filenames[i] <- file
    }
    
    # Create vectors to store the number of good observations
    nobs <- vector('numeric')
    
    # Loop through each file
    for (i in 1:length(filenames)) {
        
        # Read the file into data
        data <- read.csv(filenames[i], header = TRUE)
        
        # Return logical vectors specifying the locations that are complete
        sulfate <- !is.na(data[,"sulfate"])
        nitrate <- !is.na(data[,"nitrate"])
        
        # Create a vector for where both elements are good
        good <- sulfate & nitrate
        
        # Write to the vector
        nobs[i] <- sum(good)
    }
    
    # Coerce the vectors into a data frame
    output <- data.frame(id, nobs)
}