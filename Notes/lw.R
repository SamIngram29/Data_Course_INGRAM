read.csv()
getwd()
file.copy("../Desktop/Data_Course_INGRAM/lw.csv", "./Data")
read.csv("./Data/lw.csv")
x <- read.csv("./Data/lw.csv")
x$length *x$Width #we created a new vector as part of x ## never touch raw data
x$Area <- x$Length *x$Width 
x$LastName <- "Smith"

x$Name

paste0() #pastes them together all so you can have things look good.