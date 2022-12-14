library(tidyverse)
library(janitor)

path <- ("./Data/Utah_Religions_by_County.csv")

df <- read_csv("./Data/Utah_Religions_by_County.csv") 

Tidy <- df %>% 
  #combining Religions into one column and the percentages into another
  pivot_longer(names_to = "Religion",
               values_to = "Percent_per_county",
               cols= `Non-Religious`: Orthodox) 
#Making data into a boxplot: I don't like this much. I want to look at the religions more closely.
Tidy%>% 
  filter(Percent_per_county > 0) %>% 
  ggplot(aes(Pop_2010, 
             Percent_per_county,
             color=Religion))+
  geom_boxplot()

#messing around with the above plot to get a better look at the data visually.  I like this one a lot.
Tidy%>% 
  filter(Percent_per_county > 0) %>% 
  ggplot(aes(Pop_2010, 
             Percent_per_county,
             fill=Religion))+
  geom_boxplot()+
  facet_wrap(~Religion, scales = "free")+
  theme_minimal()+
  theme(axis.text.x = element_text(size=4),
        axis.text.y = element_text(size=4), legend.position = "none")
  
  
#looking at population of a county with religious people. I feel like I don't learn much from it though.
Tidy %>% 
  filter(Percent_per_county > 0)%>% 
  ggplot(aes(Religious,
             Pop_2010,
             color=County))+
  geom_point()


  #trying another plot to mess around with facet grid. Not sure how to make it look any better.
Tidy%>%
  filter(Percent_per_county>0) %>%
  group_by(County) %>% 
  ggplot(aes(Pop_2010, Percent_per_county, color= Religion))+
  geom_point()+
  facet_grid(~County, scales = "free",
             space= "free_y",
             margins = TRUE, 
             shrink = FALSE)+
  theme(axis.text.x = element_text(size = 5, angle = 90),
        axis.text.y=element_text(size=6),
        axis.title.x=element_text(size = 8),
        axis.title.y=element_text(size=8))


# hahahaha this is so bad. I don't even know how to make sense of it. It's terrible.             
Tidy %>% 
  filter(Percent_per_county>0) %>% 
  ggplot(aes(Percent_per_county, Pop_2010, color= Religion))+
  geom_jitter(color="black")+
  geom_smooth(se=FALSE)+
  theme_minimal()+
  facet_wrap(~Religion, scales = "free")+
  theme(legend.position = "none")


#moving on to looking at it in a better sense.
#???Does population of a county correlate with the proportion of any specific religious group in that county????

#my favorite depiction so far to answer this question. 
Tidy %>% 
  filter(Percent_per_county>0) %>% 
  ggplot(aes(Pop_2010, Percent_per_county, color= County))+
  geom_point()+
  facet_wrap(~Religion, scales = "free")+
  theme( axis.text.x = element_text(size=6, angle= 90, hjust = 1))
# I don't believe the population of a county correlates with the proportion of a specific religious group.


#???Does proportion of any specific religion in a given county correlate with the proportion of non-religious people????
#looking at non-religious only:
Tidy %>% 
  filter(Percent_per_county>0, Religion == "Non-Religious") %>% 
  ggplot(aes(Pop_2010, Percent_per_county, color= County))+
  geom_point()+
  facet_wrap(~Religion, scales = "free")+
  theme( axis.text.x = element_text(size=6, angle= 90, hjust = 1))


#Relizing I might have Tidied the data not super well? Doing it a different way:
Tidy2 <- df %>% 
pivot_longer(names_to = "Religion",
             values_to = "Percent_per_county",
             cols= `Assemblies of God` : Orthodox) 

# Plotting things out again. Haha. 
Tidy2 %>% 
  filter(Percent_per_county > 0) %>% 
  ggplot(aes(`Non-Religious`, 
             Percent_per_county,
             color=Religion))+
  geom_point()+
  geom_smooth(method="lm", se=FALSE)+
  facet_wrap(~Religion, scales = "free")+
  theme_minimal()
# I liked the above plot. It shows that the LDS religion has a correlation between proportion of a county and proportion of 
##..non-religious people. The trend line shows that really well.
