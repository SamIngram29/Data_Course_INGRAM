library(tidyverse)
library(modelr)
library(easystats)
library(broom)
library(fitdistrplus)


df <- read_csv("./Data/mushroom_growth.csv")
names(df)
#testing response variable with predictors:
df %>% 
  ggplot(aes(y=GrowthRate,x=Temperature,
             fill=Species))+
  geom_boxplot()+
  facet_wrap(~Humidity)

#testing more predictors with the response variable (GrowthRate). Facet wrapping by Nitrogen isn't a great look at the data in my opinion.
df %>% 
  ggplot(aes(y=GrowthRate,x=Temperature,
             fill=Species))+
  geom_boxplot()+
  facet_wrap(~Nitrogen)

#again:
df %>% 
  ggplot(aes(y=GrowthRate,x=Temperature,
             fill=Humidity))+
  geom_boxplot()+
  facet_wrap(~Species)

#again, but looking at Light, humidity, and species as predictors
df %>% 
  ggplot(aes(y=GrowthRate,x=Light,
             fill=Humidity))+
  geom_boxplot()+
  facet_wrap(~Species)

#again, but looking at Nitrogen, humidity, and species as predictors
df %>% 
  ggplot(aes(y=GrowthRate,x=Nitrogen,
             fill=Humidity))+
  geom_boxplot()+
  facet_wrap(~Species)

#modeling!!!
#mod1 looking at everything all together comparing to each other but not interacting with each other.
mod1 <- glm(data=df, 
            formula= GrowthRate ~ Species + Light +Humidity +Nitrogen+ Temperature)
summary(mod1) 

#looking at the coefficients:
tidy(mod1)


#Making another model to look at the data of everything but growth rate ^2:
mod2 <- glm(data=df,
            formula= GrowthRate ~ .^2)

#looking at the significant values:
tidy(mod2)

#another model looking at growthrate as a function of species and humidity interacting.
mod3 <- glm(data=df, formula= GrowthRate ~ Species * Humidity)

tidy(mod3)
  

#another model looking at all of the predictors interacting together.
mod4 <-glm(data=df, 
                    formula= GrowthRate ~ Species * Light *Humidity *Nitrogen *Temperature)
tidy(mod4) 

#another model looking at light and nitrogen being interactive.
mod5 <- glm(data=df, 
            formula= GrowthRate ~ Light *Nitrogen)
tidy(mod5)

#############################################
### Mean Square Error ###
#############################################

mean(mod1$residuals^2)
#5146.039
mean(mod2$residuals^2)
#3369.239
mean(mod3$residuals^2)
#6429.059
mean(mod4$residuals^2)
#2332.379
mean(mod5$residuals^2)
#7630.074

#############################################
###COMPARING MODELS###
#############################################
compare_performance(mod1, mod2, mod3, mod4, mod5, rank=TRUE) %>% plot()
##mod4 is the best model if I am understanding it right. Then mod2, then mod 1


#############################################
###MAKING PREDICTIONS ###
#############################################
df %>% 
  gather_residuals(mod1, mod2, mod3, mod4, mod5) %>% 
  ggplot(aes(x=model, y=resid, fill=model))+ 
  geom_boxplot()+
  geom_point(size=1)
  
df %>% 
  gather_predictions(mod1, mod2, mod3, mod4, mod5) %>% 
  ggplot(aes(x=Nitrogen, y=GrowthRate))+
  geom_boxplot(aes(y=pred, fill=model))+
  theme_bw()
#### Model 4 is the best fit model###

############################################
###Adding and Making Predictions##########
############################################

add_predictions(df,mod4) %>% 
  ggplot(aes(x=pred, y=GrowthRate,color=Species)) +
  geom_point(alpha=0.65, color="black")+
  geom_smooth()+
  theme_minimal()


###Making a hypothetical scenario###
Hyp <- data.frame(GrowthRate=375,
                  Species= "P.ostreotus",
                  Light= 15, Nitrogen= 24, 
                  Temperature= 22, Humidity= "Low")
pred= predict(mod4,newdata = Hyp)

hyp_pred <- data.frame(GrowthRate= Hyp$GrowthRate,
                       Species=Hyp$Species,
                       Light=Hyp$Light,
                       Nitrogen= Hyp$Nitrogen,
                       Temperature= Hyp$Temperature,
                       Humidity= Hyp$Humidity,
                       pred=pred)

df$PredictionType <- "Real" 
hyp_pred$PredictionType <- "Hypothetical"

fullpreds <- full_join(df,hyp_pred)


#A plot comparing the hypothetical data to the real data set
ggplot(fullpreds,aes(x=GrowthRate, y=pred, color= PredictionType))+
  geom_point(aes(y=GrowthRate))+
  geom_point(aes(y=GrowthRate))+
  theme_minimal()


#Upload responses to the following as a numbered plain text document to Canvas:
  #Are any of your predicted response values from your best model scientifically meaningless? Explain.
#In your plots, did you find any non-linear relationships? Do a bit of research online and give a link to at least one resource explaining how to deal with modeling non-linear relationships in R.
#Write the code you would use to model the data found in “/Data/non_linear_relationship.csv” with a linear model (there are a few ways of doing this)

dat <- read_csv("./Data/non_linear_relationship.csv")
#plotting the data without messing with it just to get an idea.
dat %>% 
  ggplot(aes(x=response, y=predictor))+
  geom_point()
#I kind of get it, but also not quite sure how to go about completing this portion of the assignment.