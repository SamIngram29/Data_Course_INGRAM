# finding files
list.files()
?list.files



x <- list.files(recursive = TRUE,include.dirs = TRUE,
           full.names = TRUE, pattern = "ugly",ignore.case = TRUE,
           path = "~/Desktop")
x <- list.files(pattern = ".csv", recursive = TRUE)

x[1]
y <- x[1]
?readLines
readLines(y)[1:3]

z <- read.csv(y)
z$IATA_CODE[3]
z$IATA_CODE

myvec <- c(1,3,5,7,9)
c("a","c","e")
z$IATA_CODE[myvec]

x
list.files(recursive = TRUE,pattern = "grade",ignore.case = TRUE,
           full.names = TRUE)

grades <- read.csv("./Data/Fake_grade_data.csv")

class(grades)

# data frame is []: [row,col]
grades[2,2]

grades [3,c(1,3,5)]

a <-c(TRUE,TRUE,FALSE)

#list of students who have > 15 on ass 1

grades$Assignment_1 >15

grades$Student[grades$Assignment_1>15]

library(tidyverse)

# TRUE + 1
# FALSE + 1
# true + 1
