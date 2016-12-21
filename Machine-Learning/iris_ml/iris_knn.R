# KNN - Iris
# Author: Martin Abeleda
# Date: 21/12/16

# Scatterplot for sepal length v width
qplot(iris$Sepal.Length, iris$Sepal.Width, xlab = "Sepal Length", ylab = "Sepal Width", colour = iris$Species)

# Scatterplot for petal length v width
qplot(iris$Petal.Length, iris$Petal.Width, xlab = "Petal Length", ylab = "Petal Width", colour = iris$Species)

# View first 10 data points
head(iris, n = 10)

# View Column names
names(iris)

# View the structure of iris
str(iris)

# Summary of dataset
summary(iris)

# View the proportion of the species
round(prop.table(table(iris$Species))*100, digits = 1)

# Normalise the numerical columns of iris
iris_norm <- as.data.frame(lapply(iris[,1:4], normalise))

# Set the seed
set.seed(1)

# Create a vector that separates the samples evenly by species
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.67, 0.33))

# We want 2/3 of the data for training and the rest for testing the model
iris.training <- iris[ind == 1, 1:4]
iris.test <- iris[ind == 2, 1:4]

# Species is the target variable
iris.trainLabels <- iris[ind == 1, 5]
iris.testLabels <- iris[ind == 2, 5]

# Build the knn classifier considering 3 nearest neighbours
iris_pred <- knn(iris.training, iris.test, iris.trainLabels, k = 3)

# Compare the predicted values with the actual
table(iris.testLabels, iris_pred)

