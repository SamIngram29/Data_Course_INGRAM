#Vector practice week 3
x <- c(4,6,5,7,10,9,4,15)
c(4,6,5,7,10,9,4,15)<7
#answer: b. T,T,T,F,F,F,T,F

p <- c(3,5,6,8)
q <- c(3,3,3)
p+q
#answer: d. "In p + q : longer object length is not a multiple of shorter object length"

a=c(1,3,4,7,10,0)
b=c(1,2)
a+b
#answer: [1] 2 5 5 9 11 2

z <- 0:9
digits <- as.character(z)
str(digits)
#answer: d. "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"

x <- c(1,2,3,4)
(x+2)[(!is.na(x)) & x>0] -> k
str(k)
#answer: d. 3,4,5,6

s=c("a","b","c","d","e")
t=c("f","g","h","i", "j")
s+3
#error is given: "Error in s + 3 : non-numeric argument to binary operator"
#what command would you use to combine them into a single vector in alphabetical order
both <- cbind(s,t)
?cbind
str(both)

s=c("a","b","c","d","e")
v=1:5
z=c(s,v)
z[5:10]
#answer: c: "1","2","3","4","5"

#Characters Exercise
library(tidyverse)
vector="Good morning!"
str_count(vector)
nchar(vector)
#how many charactors are in "vector"?
#answer: [1] 13

x <- c("Open", "Sesame ")
y <- c("You", "Suck.")          
nchar(x)
#answer: [1] 4 7
nchar(c(x,y))
#answer: [1] 4 7 3 5

m <- "The capital of the United States is Washington, D.C"
unlist(str_split(m," "))
str_trunc(m,11, ellipsis = "")
str_sub(m,start = 13, end= 25)
#extract "Washington from m
str_sub(m, start=37, end=46)
#task accomplished


paste(m,", you idiot!", sep="")
        
#SEQUENCES
seq(1,10, by=2)
#what is the value of:
seq(1,10, by=3)
#answer: [1] 1 4 7 10
#use the seq() function to generate the sequence 9, 18, 27, 36, 45
seq(9,45, by=9)
#done

seq(1,10,length.out=5)
seq(1,10, length.out=3)
#answer: [1] 1.0 5.5 10.0

x=1:5
rep(x,2)
rep(x,2, each=2)
#what is the value of:
rep(x,each=4)
#answer: [1] 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4  5 5 5 5 

x= "hip"
y="hooray"
rep(c(rep(x,2),y),3)
#answer: [1] "hip"    "hip"    "hooray" "hip"    "hip"    "hooray" "hip"   
#[8] "hip"    "hooray"

#create a sequence with values in this order: 
#100 95 90 85 80 75 70 65 60 55 50
seq(50, 100,by=5)
?seq



#GGplot practice from Geoff:


library(tidyverse)
ggplot(iris,
       aes(x=Sepal.Width,
           y=Sepal.Length,
           color=Species)) +
  geom_point() +
  geom_smooth(data = iris[iris$Species != "setosa",],
              method="lm",
              se=FALSE) +
  labs(x="Sepal width",
       y="Sepal length") +
  theme_bw() +
  theme(legend.text = element_text(face="italic"))

### How did it only give 2 smooth fit lines??
##ANSWER: The geom_smooth(data= iris[iris$Species != "setosa"]) Is saying give a line for all 
#species EXCEPT "!=" setosa.

#How to have a line for all of them????????? My code change:
library(tidyverse)
ggplot(iris,
       aes(x=Sepal.Width,
           y=Sepal.Length,
           color=Species)) +
  geom_point() +
  geom_smooth(data = iris,
              method="lm",
              se=FALSE) +
  labs(x="Sepal width",
       y="Sepal length") +
  theme_bw() +
  theme(legend.text = element_text(face="italic"))


#PRACTICE PLOT 2: Question- Why does this code not work??
#ANSWER: It doesn't work because Cyl is capitalized. in the data set it is not capitalized.
library(tidyverse)
ggplot(mtcars,
       aes(x=disp,
           y=mpg,color=factor(Cyl))) +
  geom_smooth(color="black",
              se=FALSE,
              alpha=.5,
              linetype=2) +
  geom_point() +
  labs(color="Cylinders",
       x="Miles per gallon",
       y="Displacement (cu.in.)") +
  theme_bw() +
  scale_color_manual(values = c("darkred","dodgerblue","darkgreen"))

#My correction of the code to make it work:
library(tidyverse)
ggplot(mtcars,
       aes(x=disp,
           y=mpg,color=factor(cyl))) +
  geom_smooth(color="black",
              se=FALSE,
              alpha=.5,
              linetype=2) +
  geom_point() +
  labs(color="Cylinders",
       x="Miles per gallon",
       y="Displacement (cu.in.)") +
  theme_bw() +
  scale_color_manual(values = c("darkred","dodgerblue","darkgreen"))

