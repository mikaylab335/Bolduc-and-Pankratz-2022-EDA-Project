library(tidyverse)

age_groups_of_people_fully_vaccinated <- 
  read_csv("data/age_groups_of_people_fully_vaccinated.csv", skip=3, 
           col_names = c("age_group", "fully_vaccinated"), 
           col_types="c_i___") %>% 
  print()

vax_data <- 
  read_csv("data/COVID-19_Vaccination_Demographics_in_the_United_States_National.csv") %>% 
  print()

vax_data %>% 
  filter(Date=="03/27/2022", 
         str_starts(Demographic_category, "Ages_"), 
         Demographic_category!="Ages_<12yrs") %>% 
  mutate(
    age_group=str_remove(Demographic_category, "Ages_"),
    age_group = str_replace_all(age_group, "_", " "),
#    age_group = factor(age_group, levels = c("<5"))
  ) %>% 
  select(age_group, Series_Complete_Pop_pct_agegroup)

cases_by_age_group <- 
  read_csv("data/cases_by_age_group.csv", skip=3,
           col_names = c("age_group", "covid_cases"),
           col_types="c_i__") %>%
  print()

ggplot(data=age_groups_of_people_fully_vaccinated)+
  geom_col(aes(x=age_group, y=fully_vaccinated))
