# Decision Tree - Iris
# Author: Martin Abeleda
# Date: 21/12/16

# Set the seed
set.seed(1)

# Create a vector that separates the samples evenly by species
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.67, 0.33))

# We want 2/3 of the data for training and the rest for testing the model
iris.training <- iris[ind == 1, ]
iris.test <- iris[ind == 2, 1:4]

# Species is the target variable
iris.trainLabels <- iris[ind == 1, 5]
iris.testLabels <- iris[ind == 2, 5]

# Build a decision tree
fit <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
             data = iris.training,
             method = "class")
plot(fit)
text(fit)

# Predict the species of the test data
iris.test$Species <- predict(fit, iris.test, type = "class")

# Compare predictions with actual
table(iris.test$Species, iris.testLabels)
