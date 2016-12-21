# Trevor Stephens -  Tutorial 4: Feature Engineering
# Author: Martin Abeleda
# Date: 21/12/16

# Import the datasets
test <- read.csv("test.csv", stringsAsFactors = FALSE)
train <- read.csv("train.csv", stringsAsFactors = FALSE)

# Merge the training and testing datasets by row
test$Survived <- NA
combi <- rbind(train, test)

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

# Split back into test and train sets
train <- combi[1:891, ]
test <- combi[892:1309, ]


# Build a new tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID, 
             data = train, method = "class")
fancyRpartPlot(fit)

plot(fit)
text(fit)

# Make prediction and output to submission file
prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = prediction)
write.csv(submit, file = "tutorial4_output.csv", row.names = FALSE)




