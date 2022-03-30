library(tidyverse)

age_groups_of_people_fully_vaccinated <- 
  read_csv("data/age_groups_of_people_fully_vaccinated.csv", skip=3, 
           col_names = c("age_group", "fully_vaccinated"), 
           col_types="c_i___") %>% 
  print()

order <- c("5-11", "12-17", "18-24", "25-39", 
           "40-49", "50-64", "65-74", "75+")

read_csv("data/COVID-19_Vaccination_Demographics_in_the_United_States_National.csv")

## vaccination
# raw data
vax_data <- 
  read_csv("data/COVID-19_Vaccination_Demographics_in_the_United_States_National.csv") %>% 
  filter(
    Date=="03/27/2022", 
    str_starts(Demographic_category, "Ages_")
  ) %>% 
  mutate(
    age_group=str_remove(Demographic_category, "Ages_"),
    age_group=str_remove(age_group, "_yrs"),
  ) %>% 
  filter(!age_group %in% c("<12yrs", "<5yrs", "12-15", "16-17")) %>% 
  select(age_group, Series_Complete_Pop_pct_agegroup) %>% 
  mutate(age_fct = factor(age_group, levels = order))%>% 
  print()
 
ggplot(data=vax_data)+
  geom_col(mapping = aes(x=age_fct, Series_Complete_Pop_pct_agegroup), 
           fill = "#a6192e") +
  labs(y="% Fully Vaccinated", x="Age")



 
  # + geom_jitter(size=3)+
  theme_gray(base_size = 24)
  
## cases
# raw data
case_data <- read_csv("data/COVID-19_Vaccination_and_Case_Trends_by_Age_Group__United_States (1).csv") %>% 
 select(-c(Administered_Dose1_pct_agegroup, Series_Complete_Pop_pct_agegroup, '7-day_avg_group_cases_per_100k')) %>% 
  print()


