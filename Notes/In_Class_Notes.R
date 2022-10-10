library(tidyverse)  #type this at the beginning of any assignment
data("iris") #load the data
df <- iris #rename so it's easier

#making a plot!!
ggplot(data=df,
       mapping = aes(x=Petal.Length,
                     y=Petal.Width,
                     color=Species,
                     shape=Species,
                     size=Sepal.Length)) +        #mapped to a COLUMN in the data set. aes "aesthetics"
  geom_point() +
  geom_smooth(method = "lm")    #method "lm" gives you a straight line
#change themes using "themes_", change labels- labs()

#Practice!

ggplot(data=df, 
       mapping= aes(x=Sepal.Width,
                    y=Petal.Width,
                    fill=Species,)) +
  geom_boxplot()+ geom_jitter()       #Want a specific color? Use color picker on google
                                      #aesthetics NEED to be the name of a column in your data frame

#9/14/2022 Wednesday
#PRACTICE SOME MORE!! USE mtcars data set.
#no colored dots:
library(tidyverse)
library(patchwork)
data("iris")

p1 <- iris %>%      #making it its own vector/object
  ggplot(data= iris,
       mapping= aes(x=Sepal.Length,
                    y=Sepal.Width,
                    color=Species))+
geom_point(color="black")+
geom_smooth(method = "lm",se=FALSE) #"se" standard error

p1 # to view the plot

#colored dots:
data("iris")

p2 <- iris %>%
ggplot(data= iris,
       mapping= aes(x=Sepal.Length,
                    y=Sepal.Width,
                    color=Species))+
  geom_point()+
  geom_smooth(method = "lm",se=FALSE)

p2 # to view the plot

#combining both plots to one:
#assign each plot its own vector and then add them together.
p1+p2 #combines them to one screen

#mess around:
p1+p2/p1

#save plot as a file:
dir.create("Figures") #creates a new folder
ggsave("./Figures/myfirstplot.png",p1) #you can name your file

#you can save the dimensions to print it :) add plot= p1, width, height, dpi (dots per inch)

#using patchwork to combine multiple plots
((p1+p2) / p1/(p1+p2)

  p3 <- p2 +
    theme_minimal()+ labs(y="Sepal Lenth",   #labs= editing LABELS of the plot.
                          title="PLANTS",
                          subtitle= "yuppers",
                          caption= "Data from iris")
  ggsave(".Figures/mysecondplot.png", p2, width=4, height=4, dpi=300)
  
p4 <- p3 +
  theme(axis.text.x = element_text(face = "bold.italic",
                                   size=14,
                                   color="blue"),
        plot.background = element_rect(fill="red"),
        axis.title=element_text(size=18, face= "bold"))

#install colorblindr
remotes::install_github("wilkelab/cowplot")
install.packages("colorspace", repos = "http://R-Forge.R-project.org")
remotes::install_github("clauswilke/colorblindr")


p6 <- 
  ggplot(iris,aes(x=Species, y=Sepal.Length,fill=Species))+
  geom_boxplot()
p6

pallet <- c("#1e15b3", "#158bb3", "#6115b3") #making my own pallet
p6+
  scale_fill_grey()
p6 +
  scale_fill_manual(values=pallet)

p6+
 scale_fill_viridis_d(option = "magma")#prefilled pallets

ggplot(iris,aes(x=Sepal.Length,
                y=Sepal.Width,
                color=Sepal.Width))+
  geom_point()+
scale_color_viridis_c(option="inferno")

viridis::rocket(100)      #:: means "give me"

  
  
#9/19/22
#Download some more packages: ggimage and GGally
library(GGally)
GGally::ggpairs(iris)    #there is a lot you can do. Google to get more practice
#give you a lot of data graphs to get an idea of your data. A good place to start when
#looking at your data.
# this is great to look at to get hypothesis ideas.
?ggpairs


#another thing to learn:
iris %>% #ctrl shift M  it is a pipe... it passes things from the left to the right.
  ggplot
#same as:
ggplot(iris)

sum(1:10)
1:10 %>%  sum

#why do the pipe version??? Helps to be more readable and deal with a lot more data inputs.
#practice:
   1:10 %>% sum()
data=iris   
iris %>% 
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Species))+
  geom_point()

iris %>% 
  filter(Species != "setosa") %>% #from left side of the pipe then stuff on the right.
  filter(Sepal.Length < 7 & Sepal.Length >5) %>% 
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Species))+
  geom_point()+
  facet_wrap(~Species) # separate subplots for each level of a categorical.

#try on your own:
iris %>% 
  ggplot(aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  geom_point(color="black")+ geom_smooth(method="lm", s) #reorder=TRUE)+
  facet_wrap(~Species)+ 
  theme_bw()+theme(strip.text = element_text(face="italic"), legend.position = "none")

iris %>% 
  ggplot(aes(x=Species, y=Petal.Length))+
  geom_violin()  
#how to order the species in whatever order you please
levels(iris$Species) <- c("virginica", "versicolor", "setosa") #BAD!!!! Just renames it.
data("iris")

iris %>% 
  mutate(Sepal.Area=Sepal.Length*Sepal.Width, #making a new column
         Species=factor(Species,levels=c("virginica", "versicolor", "setosa"))) %>% 
                          ggplot(aes(x=Species, y=Petal.Length)) +
                          geom_violin()#red the species.
                      

iris %>% 
  group_by(Species) %>% summarize(max_sep_len=max(Sepal.Length), 
                                  min_sep_len=min(Sepal.Length),
                                  mean_sep_len=mean(Sepal.Length),
                                  sd_sep_len=sd(Sepal.Length))
#grouping by "Species" and then summarizing it by their groups and finding max and min, etc.
##HELPS WITH A TASK ON THE EXAM 1


#9/21/22 IN CLASS NOTES
# R challenge
# using mutate() and filter() pick the rows of iris where at least 2 of any of the
# following conditions are met:
#   Sepal.Length is greater than 5.8
#   Sepal.Width is greater than 3
#   Petal.Length is greater than 3.7
#   Petal.Width is greater than 1.2
# So, the rows must meet TWO OR MORE of those conditions
# your hint...
library(tidyverse)
data("iris")
iris %>% 
  mutate(c1 = Sepal.Length > 5.8, 
         c2=Sepal.Width >3, c3= Petal.Length>3.7, c4=Petal.Width>1.2)  
  conditions= c1+c2+c3+c4 %>% 
    filter(conditions>=2) %>%
    select(ends_with ("h)"))

