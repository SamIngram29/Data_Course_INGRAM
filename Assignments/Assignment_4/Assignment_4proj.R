library(tidyverse)
library(patchwork)
#open data set
read.csv("Assignments/Assignment_4/Germination_data_Rstats.csv")
#Assign the data set with a name
Germination <- read.csv("Assignments/Assignment_4/Germination_data_Rstats.csv")
#create a plot
P1 <- ggplot(data = Germination,
       mapping = aes(x=Sites, y= Germ_Per, fill=Sites))+
  geom_boxplot()+
  theme_get()+labs(y= "Germination Percent", x= "Sites", title = "Germination Trial")+ 
  theme(axis.text.x = element_text(size = 7.5), axis.title=element_text(size=8, face= "bold"))

#Save the plot
ggsave("./Assignments/Assignment_4/Assignment_4plot.png",P1, width = 10, height = 8, dpi = 300)
  
Assignment 4 Code
