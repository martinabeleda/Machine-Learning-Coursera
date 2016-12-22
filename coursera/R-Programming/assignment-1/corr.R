## Complete
## Author: Martin Abeleda
## Date: 22/12/2016
##
## Usage:
# > source("corr.R")
# > source("complete.R")
# > cr <- corr("specdata", 150)
# > head(cr)
# [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
# > summary(cr)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630

corr <- function(directory, threshold = 0) {
    
    # Initialise a vector of correlations
    correlations <- vector('numeric')
    
    # Store data frame of all the completed rows
    monitors <- complete(directory, id = 1:332)
    
    # Create a vector of the file ids meeting the complete fields threshold
    observations <- monitors[monitors$nobs > threshold, "id"]
    
    # If there are obervations above the threshold
    if(length(observations)) {
        
        for (i in observations) {
            
            # Create the filepaths
            filename <- sprintf("%03d.csv", i)
            filepath <- paste(directory, filename, sep="/")
            
            # Read the data
            data <- read.csv(filepath)
            
            # Figure out the complete cases
            completes <- data[complete.cases(data),]
            
            # Find the correlations between pollutant levels
            correlations <- c(correlations, cor(completes$sulfate, completes$nitrate))
            
        }
    }
    else {
        correlations <- vector('numeric', length = 0)
    }
    correlations
}