# Kmeans Clustering - Iris
# Author: Martin Abeleda
# Date: 21/12/16

install.packages('datasets')
library(datasets)

# Create my version of iris
my_iris <- iris

# Remove Species Data
my_iris$Species <- NULL

# Apply kmeans with 3 clusters
kc <- kmeans(my_iris, 3)

# Compare Species with clustering result
table(iris$Species, kc$cluster)

# Plot the clusters and their centres for sepal length and width
plot(my_iris[c("Sepal.Length", "Sepal.Width")], col = kc$cluster)
points(kc$centers[,c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 2)

# Plot the clusters and their centres for petal length and width
plot(my_iris[c("Petal.Length", "Petal.Width")], col = kc$cluster)
points(kc$centers[,c("Petal.Length", "Petal.Width")], col = 1:3, pch = 8, cex = 2)

