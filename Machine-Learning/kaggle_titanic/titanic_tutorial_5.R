# Trevor Stephens -  Tutorial 5: Random Forests
# Author: Martin Abeleda
# Date: 21/12/16

# Import the datasets
test <- read.csv("test.csv")
train <- read.csv("train.csv")

# Merge the training and testing datasets by row
test$Survived <- NA
combi <- rbind(train, test)

# Convert to a string
combi$Name <- as.character(combi$Name)

# Isolate the title out of the names
combi$Title <- sapply(combi$Name, FUN = function(x){strsplit(x, split = '[,.]')[[1]][2]})

# Strip out the spaces from the beginning of the title
combi$Title <- sub(' ', '', combi$Title)

table(combi$Title)

# Combine some similar titles
combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'

# Change back to a factor
combi$Title <- factor(combi$Title)

# Combine family size
combi$FamilySize <- combi$SibSp + combi$Parch + 1

# Combine family name with family size to differentiate families better
combi$Surname <- sapply(combi$Name, FUN = function(x) {strsplit(x, split = '[,.]')[[1]][1]})
combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep = "")

# Call families of 2 or less small
combi$FamilyID[combi$FamilySize <= 2] <- 'Small'

# Delete erroneous family IDs
famIDs <- data.frame(table(combi$FamilyID))
famIDs <- famIDs[famIDs$Freq <= 2, ]
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'

# Convert to a factor
combi$FamilyID <- factor(combi$FamilyID)

summary(combi$Age)

install.packages('rpart')
library(rpart)

# Grow a tree on the subset of data with ages
agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize,
                data = combi[!is.na(combi$Age), ],
                method = "anova")

# Replace missing ages
combi$Age[is.na(combi$Age)] <- predict(agefit, combi[is.na(combi$Age), ])

# Summarise the data
summary(combi)

# Note that the embarked field has some missing values
summary(combi$Embarked)

# Replace the missing ones with "S" since that is the majority
combi$Embarked[which(combi$Embarked == '')] <- "S"

# Convert to a factor
combi$Embarked <- factor(combi$Embarked)

# Note that Fare has one NA
summary(combi$Fare)

# Replace the NA with the median fare
combi$Fare[which(is.na(combi$Fare))] <- median(combi$Fare, na.rm = TRUE)

# Random Forests may only take factors of up to 32 levels so we need to manually reduce the number of levels in FamilyID
combi$FamilyID2 <- combi$FamilyID

# Convert to a character string
combi$FamilyID2 <- as.character(combi$FamilyID2)

# Increase the small family cut-off to 3 people
combi$FamilyID2[combi$FamilySize <= 3] <- 'Small'

# Convert back to a factor
combi$FamilyID2 <- factor(combi$FamilyID2)

# Split back into test and train sets
train <- combi[1:891, ]
test <- combi[892:1309, ]


# Install and load the randomForest package
install.packages('randomForest')
library(randomForest)

# Set a random seed
set.seed(415)

# Create the model
fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + 
                                          Embarked + Title + FamilySize + FamilyID2,
                    data = train,
                    importance = TRUE,
                    ntree = 2000)
  
# Check which variables were important
varImpPlot(fit)

# Make the prediction and export
prediction <- predict(fit, test)
submit <- data.frame(PassengerId = test$PassengerId, Survived = prediction)
write.csv(submit, file = "tutorial5_output.csv", row.names = FALSE)

# Install and load the party package
install.packages('party')
library(party)

set.seed(415)

# Build a conditional forest
fit <- cforest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + 
                                    Embarked + Title + FamilySize + FamilyID2,
                    data = train,
                    controls = cforest_unbiased(ntree = 2000, mtry = 3)) 

# Make the prediction and export
prediction <- predict(fit, test, OOB = TRUE, type = "response")
submit <- data.frame(PassengerId = test$PassengerId, Survived = prediction)
write.csv(submit, file = "tutorial5_output2.csv", row.names = FALSE)