#Continuing week 8 modeling.
##MODELS: To understand the world. Comparing at least 2 variables.

library(tidyverse)
library(modelr)
library(easystats)
library(palmerpenguins)
library(broom)

penguins
names(penguins)

#response variable (dependent variable) is body_mass_g
#predictors: Island, sex, species... (we will start looking at these)

penguins %>% 
  filter(!is.na(sex)) %>% 
  ggplot(aes(y=body_mass_g, x=species,
             fill=sex))+
  geom_boxplot()+
  facet_wrap(~island)+
  theme(axis.text.x = element_text(angle=90,hjust=1))



#modeling!!!
#formula: response ~predictor

mod1 <- glm(data=penguins %>% 
      filter(!is.na(sex)),
    formula= body_mass_g ~ sex +island + species)
#look at it?

summary(mod1)

#Coefficients are the most important to look at.
tidy(mod1)  %>%  #with package "broom" 
  filter(p.value< 0.05)

#getting rid of insignificant variables:
mod2 <- glm(data=penguins %>% 
              filter(!is.na(sex)),
            formula= body_mass_g ~ sex +species)
tidy(mod2) %>% 
  filter(p.value<0.05)

#easystats

report(mod2)
model_performance(mod2)
compare_performance(mod1,mod2) #AIC telling you how much variables you have in your model. Smaller # is better

#residuals= measures the prediction outcome to reality (errors)
#R^2 value means how fit it is or how it has improved from the mean.

#making a model3:
mod3 <- glm(data=penguins %>% 
              filter(!is.na(sex)),
            formula= body_mass_g ~ sex * species)    #*means how they influence each other
compare_performance(mod1,mod2,mod3) %>% plot()

#looking at other variables:
mod4 <- glm(data=penguins %>% 
              filter(!is.na(sex)),
            formula= body_mass_g ~ .^2)   #.^2 means everything everything after body_mass_g squared.
mod4 %>% summary()

step <- MASS::stepAIC(mod4)  #takes out anything that isn't significant in your model. Can be helpful but know youre data!!!
step$formula  #sees the formula of comparing things to each other.

#looking at other formulas from MASS::stepAIC mechanism.
mod5 <- glm(data=penguins %>% 
              filter(!is.na(sex)),
            formula= step$formula)

compare_performance(mod3,mod4, mod5) %>% plot






#10/19/22 Inclass

#LHS/ response / outcome / dependent
#y~ x + z (additive)
# y ~ x * z (interactive)
sim3
sim3 %>% 
  ggplot(aes(x=x1, y=y, color=x2))+
  geom_point()+
  geom_smooth(method="lm")

#effect of x1 depends on value of x2 
#x1 and x2 interact!!

#making some models:
mod1 <- glm(data= sim3,
            formula= y ~ x1)

mod2 <- glm(data=sim3,
            formula= y~ x1* x2)   #y ~ x1 + x2 + x1:x2 is another way of saying this function.

mod3 <- glm(data=sim3,
            formula= y ~ x1 + x2)


compare_performance(mod1, mod2, mod3, rank=TRUE)



add_predictions(sim3, mod1) %>% 
  ggplot(aes(x=x1, y=pred))+ 
  geom_point()

add_predictions(sim3, mod2) %>% 
  ggplot(aes(x=x1, y=pred))+ 
  geom_point()

add_predictions(sim3, mod3) %>% 
  ggplot(aes(x=x1, y=pred, color=x2))+ 
  geom_point()


#a faster way of predicting:  gather_predictions makes it possible to compare/predict multiple models to each other.

gather_predictions(sim3, mod1, mod2, mod3) %>% 
  ggplot(aes(x=x1, y=pred, color=x2))+
  geom_point()+ geom_line()+
  facet_wrap(~model)



#building a model for mpg

mpg %>% glimpse

mod4 <- 
  glm(data=mpg,
      formula= cty ~cyl *displ) #trains a model
add_predictions(mpg,mod4) %>% 
  ggplot(aes(x=displ, y=pred, color=factor(cyl)))+
  geom_point()+
  geom_point(aes(y=cty), color= "black", alpha= .2)


#creating our own data frame to test some more modeling.
newcars <- data.frame(displ = c(40,1.5,3),
                      cyl= c(4,6,8))
#all models are wrong, but some are useful. Don't think models are reliable.
add_predictions(newcars,mod4)


mpg %>% 
  ggplot(aes(x=displ, y=cty))+
  geom_point()+
  geom_smooth(method="lm", formula=y~ poly(x,2))  #ploy(x,2): 2=bends in line (1 curve point)

mod5 <- glm(data=mpg,
            formula= cty ~poly(displ,2))
add_predictions(mpg,mod5) %>% 
  ggplot(aes(x=displ, y=pred, color=cyl))+
  geom_point()


#messing arroun with curves/ways to minipulate the plot
ggplot(mpg,aes(x=log10(cty)))+
  geom_density()

ggplot(mpg, aes(x=displ, y=log(cty)))+
  geom_point()



#another look:
lehi <-  read_rds("C:/Users/User/Downloads/Lehi_Home_Sales.RDS")
lehi$net_sold_price
lehi %>% #not normal
  ggplot(aes(x=log10(net_sold_price)))+
  geom_density()

library(palmerpenguins)


df <- penguins %>% 
  mutate(female=case_when(sex=="female" ~TRUE,
                          TRUE~FALSE))   #making sex true or false to test a different kind of modeling
#logistic regression  : LOGISTIC = "S"CURVE
mod6 <- glm(data= df,
            formula= female ~ body_mass_g * bill_length_mm *species,
            family= "binomial")   #family only have two things (True or False) If you have TRUE or FALSE then family MUST= "binomial"
predict(mod6,data.frame(body_mass_g= 3000,
                        bill_length_mm=20,
                        species= "Gentoo"), type = "response") #Memorize type= "response!!!!

add_predictions(df, mod6, type = "response") %>% 
  ggplot(aes(x=pred, y=female, color=female))+
  geom_point()

#another example:
mpg %>% 
  mutate(good_mileage = case_when(cty>25 ~ TRUE,
                                  TRUE ~ FALSE)) %>% 
glm(data=.,
    formula= good_mileage~ cyl* trans * displ,
    family= "binomial") %>% 
  add_predictions(data=mpg,type="response") %>% 
  ggplot(aes(x=pred, y=cty))+
  geom_point()
