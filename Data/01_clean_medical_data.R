library(tidyverse)
library(readxl)
library(janitor)
path<- "C:/Users/User/Data_Course_INGRAM/Assignments/Assignment_7/messy_bp.xlsx" 
df <- read_xlsx(path,skip=3) %>% clean_names()
extranames <- read_xlsx(path,skip=2,n_max=1)%>% 
  select(starts_with("Visit")) %>% 
  names() %>% make_clean_names()
df %>% 
  select(starts_with("bp"))

bp <- df %>% select(starts_with("bp_"))

hr <- df %>% 
  select(starts_with("hr_"))

patients <- df %>% 
  select(-starts_with("bp_")) %>% 
  select(-starts_with("hr_"))


paste0(patients$year_birth,"-", 
       patients$month_of_birth,"-",
       patients$day_birth) %>% as.Date()


patients <- 
  patients %>% 
  mutate(birthdate=as.Date(paste0(year_birth,"-",
                                  month_of_birth, "-",
                                  day_birth))) %>% 
  select(-contains("_birth")) %>% 
  mutate(pat_id= 1:nrow(.)) %>% #(.)hatever you just piped to to infinity pretty much.
  mutate(hispanic= case_when(hispanic =="Hispanic" ~ TRUE,
                             TRUE ~ FALSE)) %>% 
  mutate(race=race %>%  str_to_lower() %>% 
           str_replace("caucasian","white"),
         sex=sex %>% str_to_lower())

names(bp) <- extranames
names(hr) <- extranames

bp <- 
  patients %>% 
  bind_cols(bp) %>% 
  pivot_longer(starts_with("visit_"), names_to = "visit", values_to = "bp") %>% 
  separate(bp, into= c("systolic", "diastolic"), convert = TRUE)

hr <- 
  patients %>% 
  bind_cols(hr) %>% 
  pivot_longer(starts_with("visit_"), names_to = "visit", values_to = "hr")

df <-  full_join(bp,hr) %>% mutate(visit= visit %>% str_remove("visit_") %>% as.numeric())
View(df)

saveRDS(df, "./Data/clean_bp.RDS")
##Ctrl-alt-b : runs everything again from where ever your cursor is.
#patients$race %>%
#str_to_lower() %>%   #makes the column lower case
#str_replace("caucasian", "white")