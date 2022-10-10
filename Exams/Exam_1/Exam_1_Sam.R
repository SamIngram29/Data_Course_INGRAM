library(tidyverse)
library(dplyr)
#I: Read the cleaned covid data into an R data frame:
read.csv("C:/Users/User/Data_Course_INGRAM/Exams/BIOL3100_Exams/Exam_1/cleaned_covid_data.csv")
#Assign it to a data frame:
Covid <- read.csv("C:/Users/User/Data_Course_INGRAM/Exams/BIOL3100_Exams/Exam_1/cleaned_covid_data.csv")
CD <- data.frame(Covid)


#II. Subset the data set to just show states that begin with “A” and save this as an object called A_states. (20 pts)
a1 <- CD[grepl("Alabama", CD$Province_State),]  
a2 <- CD[grepl("Alaska", CD$Province_State),]
a3 <- CD[grepl("Arizona", CD$Province_State),]
a4 <- CD[grepl("Arkansas", CD$Province_State),]

A_states <- data.frame(rbind(a1,a2,a3,a4))

#III. Create a plot of that subset showing Deaths over time, with a separate facet for each state. (20 pts)
A_states %>% 
  ggplot(aes(x=Last_Update,
             y=Deaths, color=Province_State))+
  ##scale_x_date(date_trans="%b %Y")+
  geom_point(size=.02)+
  geom_smooth(method="lm", se=FALSE)+ #Add loess curves WITHOUT standard error shading
  theme_bw() +
  facet_wrap(~Province_State, scales = "free") +  #Keep scales “free” in each facet
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none")
  
?scale_x_date
#scale_x_date(date_trans ="%b %Y") )##Create a scatterplot   DIE!!!!!! I CAN'T FIGURE THIS OUT. Stupid error..


#IV. (Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)
Maximum_Fatality_Ratio <- CD %>% 
  filter(Case_Fatality_Ratio != "NA") %>% 
  group_by(Province_State) %>% summarize(max(Case_Fatality_Ratio)) %>% 
  arrange(desc(y=`max(Case_Fatality_Ratio)`)) #Arrange the new data frame in descending order by Maximum_Fatality_Ratio

  
#V. Use that new data frame from task IV to create another plot. (20 pts)
Maximum_Fatality_Ratio %>% 
mutate(Province_State = fct_reorder(Province_State,-`max(Case_Fatality_Ratio)` )) %>% #x-axis arranged in descending order, just like the data frame 
  ggplot(aes(x=Province_State,
             y=`max(Case_Fatality_Ratio)`, fill=`max(Case_Fatality_Ratio)`))+  #X-axis is Province_State and Y-axis is Maximum_Fatality_Ratio
  labs(y="Max Fatality Ratio",
       x="Province State")+
  geom_bar(stat='identity')+ #bar plot
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none") #X-axis labels turned to 90 deg to be readable


#VI. (BONUS 10 pts) Using the FULL data set, plot cumulative deaths for the entire US over time

##You’ll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.
