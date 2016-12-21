# Trevor Stephens -  Tutorial 3: Decision Trees
# Author: Martin Abeleda
# Date: 21/12/16

# Load rpart
library(rpart)

# Build a decision tree based on a number of variables
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# Examine the tree
plot(fit)
text(fit)

# Better rpart graphics
install.packages('ratte')
install.packages('rpart.plot')
install.packages('RcolorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Render a nicer tree
fancyRpartPlot(fit)

# Make a prediction using this tree
prediction <- predict(fit, test, type = "class")

# Create and export a submission
submit <- data.frame(PassengerId = test$PassengerId, Survived = prediction)
write.csv(submit, file = "tutorial3_output.csv", row.names = FALSE)

# Build a decision tree overriding the defaults. Note: this tree is overfitted
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
             data = train, 
             method = "class",
             control = rpart.control(minsplit = 2, cp = 0))

# Build an interactive version of the decision tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
             data = train, 
             method = "class",
             control = rpart.control(your controls)
new.fit <- prp(fit, snip = TRUE)$obj             
fancyRpartPlot(new.fit)
