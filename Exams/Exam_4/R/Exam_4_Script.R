library(tidyverse)
library(dplyr)
#1:  Read the cleaned_covid_data.csv file into an R data frame.
df <- read_csv("./Data/cleaned_covid_data.csv")


#2: Subset the data set to just show states that begin with “A” and save this as an object called A_states.
A_states <- df %>% 
  filter(grepl("^A",Province_State))


#3: Create a plot of that subset showing Deaths over time, with a separate facet for each state. 

A_states %>% 
  ggplot(aes(x=Last_Update,
             y=Deaths, color=Province_State)) +
  geom_point(size=.02)+
  geom_smooth(method= "loess", se=FALSE)+ #Add loess curves WITHOUT standard error shading
  theme_bw() +
  facet_wrap(~Province_State, scales = "free") +  #Keep scales “free” in each facet
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none")

#4: (Back to the full data set) Find the “peak” of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate.

Maximum_fatality_ratio <- df %>% 
  filter(Case_Fatality_Ratio != "NA") %>% 
  group_by(Province_State) %>% summarize(max(Case_Fatality_Ratio)) %>% 
  arrange(desc(y=`max(Case_Fatality_Ratio)`))

#5: Use that new data frame from task IV to create another plot.

Maximum_fatality_ratio %>% 
  mutate(Province_State = fct_reorder(Province_State,-`max(Case_Fatality_Ratio)` )) %>% #x-axis arranged in descending order, just like the data frame 
  ggplot(aes(x=Province_State,
             y=`max(Case_Fatality_Ratio)`, fill=`max(Case_Fatality_Ratio)`))+  #X-axis is Province_State and Y-axis is Maximum_Fatality_Ratio
  labs(y="Max Fatality Ratio",
       x="Province State")+
  geom_bar(stat='identity')+ #bar plot
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1), legend.position = "none")

#6: (BONUS 10 pts) Using the FULL data set, plot cumulative deaths for the entire US over time
df <- df %>% group_by(Province_State) %>% mutate(cumulative_deaths=cumsum(Deaths)) 
df %>% 
  ggplot(aes(x=Last_Update, y=cumulative_deaths))+
  geom_smooth(se=FALSE, color= "red")+
  labs(x= "Time",y="Cumulative Deaths", title = "Cumulative Covid Deaths From 2020-2022")+
  theme_bw()
  
