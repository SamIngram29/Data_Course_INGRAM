library(tidyverse)
library(gganimate)

dat <- read_csv("../../Data/BioLog_Plate_Data.csv")
dat %>% View
dat %>% names
#1. Cleans this data into tidy (long) form:

Tidy1 <- dat %>% 
  rename(`24`= Hr_24,
         `48`= Hr_48,
         `144`= Hr_144)
#Creating columns that make sense
Tidy2 <- Tidy1 %>% pivot_longer(names_to = "Absorbency_Hours",
             values_to = "Absorbency_Value", cols= `24`:`144`) 


#jk change the hours to not have Hr first (I went back up to #1 and fixed it.:

Tidy2$Absorbency_Hours <-  as.numeric(Tidy2$Absorbency_Hours) 


#^^^Needed to change to numeric because plotting would suck otherwise.

#2. Creates a new column specifying whether a sample is from soil or water

#Soil <- T2[grepl("Soil_", T2$`Sample ID`),]  
#Water <- T2[grepl("Waste_", T2$`Sample ID`),]
#Then made a data set???? NOPE DOESN'T Do what I want it to.
##Googled and worked with Josh.
###Need to work with the characters and do a TRUE or FALSE statement to solidify what starts with Soil under Sample ID

Tidy2$Type=grepl("^Soil", Tidy2$`Sample ID`)

#Learned what ifelse is:
?ifelse

#create new column FINALLY
Tidy3<- Tidy2 %>% 
  mutate(Type=ifelse(Type == TRUE, "Soil", "Water"))



#3. Generates a plot that matches this one (note just plotting dilution == 0.1):
Dilution1<- Tidy3 %>% 
  filter(Dilution == 0.1) 
Dilution1 %>% 
  group_by(Substrate) %>% 
  ggplot(aes(x=Absorbency_Hours, y=Absorbency_Value, color=Type)) +
  geom_smooth(se=FALSE)+
  theme_minimal()+
  facet_wrap(~Substrate)+
  ylim(0,2)+
  theme(axis.text.y = element_text(size = 8))+
  labs(x="Time", y= "Absorbance", title = "Just dilution 0.1" )+
  theme(title = element_text(size=8))
  


#4. Generates an animated plot that matches this one (absorbence values are mean of all 3 replicates for each group):
Animated <- Tidy3 %>% 
  filter(Substrate == "Itaconic Acid") %>% 
  group_by(Absorbency_Hours,`Sample ID`, Dilution) %>% 
  summarize(Mean_absorbance=mean(Absorbency_Value),   #mean absorbency
            Absorbency_Hours=Absorbency_Hours,
            `Sample ID`=`Sample ID`,
            Dilution=Dilution,
            Rep=Rep,                                    
            `Well`=`Well`,
            Absorbency_Value=Absorbency_Value) 
   Animated %>% 
    ggplot(aes(x=Absorbency_Hours, y=Mean_absorbance, color= `Sample ID`))+
  geom_line()+     #not geom_smooth.. lol
    theme_minimal()+
    facet_wrap(~Dilution)+
    transition_reveal(Absorbency_Hours)+ #Josh helped me with this.
    labs(x="Time") 
      
    
