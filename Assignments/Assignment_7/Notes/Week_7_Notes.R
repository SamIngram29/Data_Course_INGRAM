library(carData)
library(tidyverse)

df <- full_join(MplsStops,MplsDemo)  #have to have at least
#...one variable that is the same to be able to join data.
glimpse(df)
levels(df$problem)## get to know your data more
levels(df$citationIssued) # is NO and YES. CHANGE TO TRUE OR FALSE!!!!!
levels(df$personSearch)
#Convert to TRUE OR FALSE

df$citationIssued %>% table  #taking a look at the information
#...in table form.
df$citationIssued %>% summary() #seeing all the values including
#...NA's

df %>% 
  mutate(citationIssued = case_when(citationIssued == "YES" ~ TRUE,    #anytime citation says YES we want it to say TRUE.
                                    #.... anytime it says NO we want it to say FALSE. NA we want
                                    #....it to still say NA.
                                    citationIssued == "NO" ~ FALSE,
                                    is.na(citationIssued)~FALSE,
                                    TRUE ~ FALSE)) %>% #A weird thing that "case_when" requires. It means that anything else than the above is then true.#.... that is true is false. Lame, but you have to do it.
  select(citationIssued)#wanting to look at just the citation issues column.

#Make the vehicleSearch column into TRUE or FALSE
  levels(df$vehicleSearch)
summary(df$vehicleSearch)
df %>% 
  mutate(vehicleSearch = case_when(vehicleSearch == "YES" ~TRUE,
                                   TRUE ~ FALSE)) %>%  select(vehicleSearch)
df %>% 
  mutate(suspiciousVehicleSearch= case_when(problem== "suspicious" & vehicleSearch == TRUE ~TRUE,
                                            TRUE ~ FALSE))

#Put it all together:

New_df <- 
df %>% 
  mutate(citationIssued = case_when(citationIssued == "YES" ~ TRUE,
                                    TRUE ~FALSE),
        vehicleSearch = case_when(vehicleSearch == "YES" ~TRUE,
                                          TRUE ~ FALSE),
                suspiciousVehicleSearch= case_when(problem== "suspicious" & vehicleSearch == TRUE ~TRUE,
                                                          TRUE ~ FALSE))
                
                
#Wednesday 10/5/22
library(readxl)
read_xlsx("./Assignments/messy_bp.xlsx")
