library(tidyverse)
library(janitor)
library(modelr)
library(easystats)
library(broom)
library(fitdistrplus)
#load Unicef data
df <- read_csv("./Data/unicef-u5mr.csv")

###############################################
#Making the data tidy
###############################################

tidy1 <- df %>% 
   pivot_longer(names_to = "Year", values_to = "U5MR", cols = U5MR.1950:U5MR.2015) %>% 
  mutate(Year= str_replace_all(Year, "U5MR.","")) %>%  drop_na() %>% 
  unique.data.frame()

tidy1$Year <- as.numeric(tidy1$Year)

##############################################
# Plotting each country’s U5MR over time 
##############################################
p1 <- tidy1 %>% 
  ggplot(aes(x=Year, y=U5MR))+
  geom_path()+
  facet_wrap(~Continent)

#saving it:
ggsave("./Rscript/Ingram_Plot_1.png", p1, width = 20, height = 15, dpi=300)

##############################################
# New plot showing mean U5MR over time
##############################################

p2 <- tidy1 %>%
  group_by(CountryName, Continent) %>% 
  ggplot(aes(x = Year, y = U5MR, 
             color=Continent)) + 
  stat_summary(U5MR= "mean", geom = "path")+
  labs(y="Mean_U5MR")+
  theme_bw()

#saving it:
ggsave("./Rscript/Ingram_Plot_2.png", p2, width = 15, height = 10, dpi=300)

##################################################
# Creating 3 models of U5MR
##################################################

##### MODEL 1: YEAR ##############################
tidy1 %>% glimpse

mod1 <- glm(data=tidy1,
            formula= U5MR ~ Year)
tidy(mod1)   #viewing the model

##### MODEL 2: YEAR AND CONTINENT ################
mod2 <- glm(data=tidy1,
            formula= U5MR ~ Year + Continent)
tidy(mod2) %>% 
  filter(p.value<0.05) #viewing the model

##### MODEL 3: YEAR AND CONTINENT INTERACTIVELY###
mod3 <- glm(data=tidy1,
            formula= U5MR ~ Year * Continent)
tidy(mod3) %>% 
  filter(p.value<0.05)

#################################################
### Comparing Models ############################
#################################################

compare_performance(mod1, mod2, mod3, rank=TRUE) %>% plot


gather_predictions(tidy1, mod1, mod2, mod3) %>% 
  ggplot(aes(x=Year,y=pred, color=Continent))+
  geom_line()+
  theme_bw()+
  facet_wrap(~model)

#After looking at the three models. Model #3 is the best model to help interpret the data.
# variables of year * continent show a correlation and do impact each other.

#################################################
### BONUS #######################################
#################################################
#BONUS - Using your preferred model, predict what the U5MR would be for Ecuador
#in the year 2020. The real value for Ecuador for 2020 was 13 under-5 deaths per
#1000 live births. How far off was your model prediction???
  
#Your code should predict the value using the model and calculate the difference between
#the model prediction and the real value (13).

Hyp <- data.frame(Year=2020,
                      Continent= "Americas",
                      CountryName= "Ecuador",
                      Region= "South America")
pred= predict(mod3,newdata = Hyp)

hyp_pred <- data.frame(Year= Hyp$Year,
                       Continent= Hyp$Continent,
                       CountryName= Hyp$CountryName,
                       Region=Hyp$Region,
                       pred=pred)

tidy1$PredictionType <- "Real" 
hyp_pred$PredictionType <- "Hypothetical"

fullpreds <- full_join(tidy1,hyp_pred)


##This is as far as I got... Hahaha I think I was on the right path?

