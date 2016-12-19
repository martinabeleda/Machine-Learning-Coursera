# Types of Machine Learning

## Classification

```R
# The emails dataset is already loaded into your workspace

# Show the dimensions of emails
dim(emails)

# Inspect definition of spam_classifier()
spam_classifier <- function(x){
  prediction <- rep(NA, length(x)) # initialize prediction vector
  prediction[x > 4] <- 1
  prediction[x >= 3 & x <= 4] <- 0
  prediction[x >= 2.2 & x < 3] <- 1
  prediction[x >= 1.4 & x < 2.2] <- 0
  prediction[x > 1.25 & x < 1.4] <- 1
  prediction[x <= 1.25] <- 0
  return(prediction) # prediction is either 0 or 1
}

# Apply the classifier to the avg_capital_seq column: spam_pred
spam_pred <- spam_classifier(emails$avg_capital_seq)

# Compare spam_pred to emails$spam. Use ==
spam_pred == emails$spam
```

## Regression

1. Fit the linear model using `model <- lm(y ~ x)`.

2. Create a frame of the values to predict `unseen <- data.frame(x = <...>)`.

3. Predict the output for the values `pred <- predict(model, unseen)`.

4. Plot.

Example

```R
# linkedin is already available in your workspace

# Create the days vector
days <- 1:21

# Fit a linear model called on the linkedin views per day: linkedin_lm
linkedin_lm <- lm(linkedin ~ days)

# Predict the number of views for the next three days: linkedin_pred
future_days <- data.frame(days = 22:24)
linkedin_pred <- predict(linkedin_lm, future_days)

# Plot historical data and predictions
plot(linkedin ~ days, xlim = c(1, 24))
points(22:24, linkedin_pred, col = "green")
```


## Clustering

```R
# Set random seed. Don't remove this line.
set.seed(1)

# Chop up iris in my_iris and species
my_iris <- iris[-5]
species <- iris$Species

# Perform k-means clustering on my_iris: kmeans_iris
kmeans_iris <- kmeans(my_iris, 3)

# Compare the actual Species to the clustering using table()
table(species, kmeans_iris$cluster)

# Plot Petal.Width against Petal.Length, coloring by cluster
plot(Petal.Length ~ Petal.Width, data = my_iris, col = kmeans_iris$cluster)
```

# Supervised vs. Unsupervised
## Supervised Learning

* To find a function which can be used to assign a class or value to unseen observations.

* Given a set of labelled observations.

* May compare real labels with the predicted labels.

### Decision Tree Model

```R
# Set random seed. Don't remove this line.
set.seed(1)

# Take a look at the iris dataset
str(iris)
summary(iris)

# A decision tree model has been built for you
tree <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
              data = iris, method = "class")

# A dataframe containing unseen observations
unseen <- data.frame(Sepal.Length = c(5.3, 7.2),
                     Sepal.Width = c(2.9, 3.9),
                     Petal.Length = c(1.7, 5.4),
                     Petal.Width = c(0.8, 2.3))

# Predict the label of the unseen observations. Print out the result.
predict(tree, unseen, type = "class")
```

## Unsupervised Learning

* Does not require labelled data.

* Example: Clustering

* Not able to compare real labels.

### Clustering

```R
# The cars data frame is pre-loaded

# Set random seed. Don't remove this line.
set.seed(1)

# Explore the cars dataset
str(cars)
summary(cars)

# Group the dataset into two clusters: km_cars
km_cars <- kmeans(cars, 2)

# Print out the contents of each cluster
print(km_cars$cluster)
```

```R
# The cars data frame is pre-loaded

# Set random seed. Don't remove this line
set.seed(1)

# Group the dataset into two clusters: km_cars
km_cars <- kmeans(cars, 2)

# Add code: color the points in the plot based on the clusters
plot(cars, col = km_cars$cluster)

# Print out the cluster centroids
print(km_cars$centers)

# Replace the ___ part: add the centroids to the plot
points(km_cars$centers, pch = 22, bg = c(1, 2), cex = 2)
```

## Semi-Supervised Learning

* A lot of unlabelled observations with a few that are.

* Group similar observations using clustering.

* Use the existing labels combined with clustering information to provide labels. 


