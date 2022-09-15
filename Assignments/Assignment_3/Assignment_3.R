# YOUR REMAINING HOMEWORK ASSIGNMENT (Fill in with code) ####

# 1.  Get a subset of the "iris" data frame where it's just even-numbered rows

seq(2,150,2) # here's the code to get a list of the even numbers between 2 and 150

dat[seq(2,150,2),]


# 2.  Create a new object called iris_chr which is a copy of iris, except where every column is a character class
data("iris")
iris$Sepal.Length<-as.numeric(iris$Sepal.Length)

iris_chr <- data.frame(iris)
iris_chr$Sepal.Length <- as.character(iris$Sepal.Length)
iris_chr$Sepal.Width <- as.character(iris$Sepal.Width)
iris_chr$Petal.Length <- as.character(iris$Petal.Length)
iris_chr$Petal.Width <- as.character(iris$Petal.Width)
iris_chr$Species <- as.character(iris$Species)


as.character(iris) #does not work



# 3.  Create a new numeric vector object named "Sepal.Area" which is the product of Sepal.Length and Sepal.Width
Sepal.Area <- iris$Sepal.Length*iris$Sepal.Width


# 4.  Add Sepal.Area to the iris data frame as a new column
iris$Sepal.Area <- Sepal.Area


# 5.  Create a new data frame that is a subset of iris using only rows where Sepal.Area is greater than 20 
# (name it big_area_iris)
data("iris")
str(iris)
iris$Sepal.Area>20
big_area_iris <- subset(iris, iris$Sepal.Area>20)
# 6.  Upload the last numbered section of this R script (with all answers filled in and tasks completed) 
# to canvas
# I should be able to run your R script and get all the right objects generated

Assignment_3
