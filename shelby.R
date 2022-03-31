library(tidyverse)

age_groups_of_people_fully_vaccinated <- 
  read_csv("data/age_groups_of_people_fully_vaccinated.csv", skip=3, 
           col_names = c("age_group", "fully_vaccinated"), 
           col_types="c_i___") %>% 
  print()

order <- c("5-11", "12-17", "18-24", "25-39", 
           "40-49", "50-64", "65-74", "75+")

## vaccination
# raw data
vax_data <- 
  read_csv("data/COVID-19_Vaccination_Demographics_in_the_United_States_National.csv") %>% 
  filter(
    str_starts(Demographic_category, "Ages_")
  ) %>% 
  mutate(
    Date = as.Date(Date, format = "%m/%d/%Y"),
    age_group=str_remove(Demographic_category, "Ages_"),
    age_group=str_remove(age_group, "_yrs"),
  ) %>% 
  filter(!age_group %in% c("<12yrs", "<5yrs", "12-15", "16-17")) %>% 
  mutate(age_group = factor(age_group, levels = order)) %>%
  rename(
    per_vax = Series_Complete_Pop_pct_agegroup, 
    date = Date
  ) %>% 
  select(date, age_group, per_vax) %>%
  print()
 
vax_data %>% 
  filter(date == max(date)) %>% 
  ggplot()+
  geom_col(mapping = aes(x=age_group, per_vax), 
           fill = "#a6192e") +
  labs(y="% Fully Vaccinated", x="Age Range", title = "Vax data on March 27, 2022")

  # + geom_jitter(size=3)+
  theme_gray(base_size = 24)

vax_data %>% 
  ggplot(aes(x = date, y = per_vax, color = age_group)) +
  geom_line()
    
## cases
# raw data
case_data <- read_csv("data/cases.csv") %>% 
  select(-c(deaths)) %>% 
  print()

ggplot(case_data)+
  geom_col(mapping = aes(x=date, cases),
           fill = "#a6192e") +
  labs(y="# of cases", "Dates")


# raw data w age groups
library(readxl)
cases_by_age <- 
  read_excel("data/Public-Dataset-Age (1).XLSX") %>% 
  select(-c(AR_TOTALPERCENT, AR_NEWCASES, 
            AR_NEWPERCENT, AR_TOTALDEATHS, AR_NEWDEATHS)) %>% 
  rename(date = DATE, age_range=AGE_RANGE, total_cases=AR_TOTALCASES) %>% 
  mutate(date = as.Date(date)) %>% 
  print()

 
cases_by_age %>%
  # filter(date == max(date)) %>%    # choose the last date
  filter(date == as.Date("2022-03-20") | date == as.Date("2021-03-20")) %>%   # choose a particular date
  ggplot()+
  geom_col(mapping = aes(x=age_range, y=total_cases, fill=as.factor(date)),
           position="dodge2") +
  labs(y="# of Cases", x="Age Range")

cases_by_age %>% 
  ggplot(aes(x = date, y = total_cases, color = age_range)) +
  geom_line()
