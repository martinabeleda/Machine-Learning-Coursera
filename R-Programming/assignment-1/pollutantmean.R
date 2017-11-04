## Pollutant Mean
## Author: Martin Abeleda
## Date: 22/12/2016
##
## Usage:
# > source("pollutantmean.R")
# > pollutantmean("specdata", "sulfate", 1:10)
# [1] 4.064

## pollutantmean()
## This function calculates the mean of a pollutant across a specified list of monitors
#  Params:
#       directory - a character vector indicating the directory of the CSV files.
#       pollutant - a string indicating the pollutant to calculate the mean for.
#                   Can be either "sulfate" or "nitrate".
#       id        - an integer vector indicating the monitor ID numbers to be used.
#  Return:
#       The mean value of the specified pollutant across the specified range of monitors.

pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    ## Create a vector of filenames
    filenames <- vector(mode = "character", length = length(id))

    # Construct a vector of the different file names
    for (i in 1:length(id)) {
        num <- id[i]
        num
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
    
    # print(filenames)
    
    # Variables to store the sum and the number of elements counted
    sum <- 0
    total <- 0

    # Open each of the files and sum the amount of pollutant in each row
    for (i in 1:length(filenames)) {

        # Read the file into data
        data <- read.csv(filenames[i], header = TRUE)

        # Create a vector of the good values for the chosen pollutant
        pollutant_vec <- data[!is.na(data[,pollutant]), pollutant]

        sum <- sum + sum(pollutant_vec)
        total <- total + length(pollutant_vec)
    }

    # Return the average
    sum/total 
}
