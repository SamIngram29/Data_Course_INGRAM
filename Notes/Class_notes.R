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
fat_flowers <- iris %>% #grabbing all the average flowers and renaming it.
  mutate(c1 = Sepal.Length > 5.8,    #mutate is creating new columns or adjusting values in them
         c2=Sepal.Width >3,
         c3= Petal.Length>3.7,                #
         c4=Petal.Width>1.2,
         conditions= c1+c2+c3+c4)%>%  
  filter(conditions>=2) %>%   #filter for picking rows
  select(-starts_with("c"))  #select for picking columns


iris %>% 
  ggplot(aes(x=Sepal.Width,y=Petal.Width,color=Species))+
  geom_blank()+
  geom_point(data=fat_flowers)



#NEW DATA SET
library(palmerpenguins)
penguins %>% glimpse
penguins %>% GGally::ggpairs()  #get a glimpse at all the data.
penguins %>% names()  
penguins %>% 
  filter(!is.na(sex)) %>% #follow with filter before the plot!!!!
  ggplot(aes(x=sex,y=body_mass_g,fill=sex))+
  geom_boxplot()+
  facet_wrap(~island)+
  scale_fill_manual(values=c("Yellow", "Red"))+
  theme_bw()+
  theme(strip.background=element_rect(fill="Orange"))#coloring the strip of the facets.
  

#ggimage

library(ggimage)
# any local file path or image URL (using URL here for simplicity)
pic <- "https://cdn.icon-icons.com/icons2/1954/PNG/512/burger_122704.png"
p <- iris %>% 
  ggplot(aes(x=Sepal.Length,y=Petal.Length)) +
  theme_minimal()
p + 
  geom_image(image=pic) # not in aes()
# Could add a column of image paths if you want different images for different "groups"
# find 3 images (URL, in this case)
pic1 <- "https://static.thenounproject.com/png/2565215-200.png"
pic2 <- "https://static.thenounproject.com/png/703110-200.png"
pic3 <- "http://www.clker.com/cliparts/t/X/X/H/f/U/wrench-md.png"
# png files with transparent backgrounds work best
# make a vector of those paths that correspond to the iris species
iris$URL <- c(rep(c(pic1,pic2,pic3),each=50)) # save as new column (for an aesthetic)
iris %>% head() # just to see how this looks in your data set
iris %>% 
  ggplot(aes(x=Sepal.Length,y=Sepal.Width)) +
  geom_image(aes(image=URL)) + # set that new character column as an aesthetic
  theme_minimal()
#can use your own images!!!!!!
#Instead of aes use geom_image(image= whatever is on your computer/desired image)


###MORE COOLNESS
library(gganimate)
