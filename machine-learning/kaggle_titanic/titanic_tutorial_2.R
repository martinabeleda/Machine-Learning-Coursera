# Trevor Stephens -  Tutorial 2: The Gender-Class Model
# Author: Martin Abeleda
# Date: 21/12/16

# Get the proportion of survivors by sex
prop.table(table(train$Sex, train$Survived), margin = 1)

# We can see that a majority of the females survived
# Update our prediction to say that all females survive
test$Survived <- 0
test$Survived[test$Sex == "female"] <- 1

# Look into the age variable
summary(train$Age)

# Create a Child variable
train$Child <- 0

# Assume any NAs are adults
train$Child[train$Age < 18] <- 1

# Create a table of survival proportions aggregated by gender and age
aggregate(Survived ~ Child + Sex, data = train, FUN = function(x) {sum(x)/length(x)})

# Break down the continuous fares column into categories
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

# Create another table aggregated by Fare2, class and sex
aggregate(Survived ~ Fare2 + Pclass + Sex, data = train, FUN = function(x) {sum(x)/length(x)})

# Make a new prediction based on this knowledge
test$Survived <- 0

# Females survive
test$Survived[test$Sex == 'female'] <- 1

# Females of class 3 and fares >= 20 don't survive
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

# Create and export a submission
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "tutorial2_output.csv", row.names = FALSE)



