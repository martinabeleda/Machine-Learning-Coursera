# Trevor Stephens -  Tutorial 1: Booting up R
# Author: Martin Abeleda
# Date: 21/12/16

# Import the datasets
test <- read.csv("test.csv", stringsAsFactors = FALSE)
train <- read.csv("train.csv", stringsAsFactors = FALSE)

# View the structure of the datasets
str(train)
prop.table(table(train$Survived))

# Create Survived column in the test data frame (assume everyone dies)
str(test)
test$Survived <- rep(0, nrow(test))

# Create and export a submission
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "tutorial1_outout.csv", row.names = FALSE)
