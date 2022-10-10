library(tidyverse)

df <-  readRDS( "C:/Users/User/Data_Course_INGRAM/Data/clean_bp.RDS")
df %>% 
  ggplot(aes(x=visit, y=systolic,color=hispanic))+
  geom_point()+
  geom_smooth()
