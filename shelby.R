library(tidyverse)
library(readr)
age_groups_of_people_fully_vaccinated <- read_csv("data/age_groups_of_people_fully_vaccinated.csv")
View(age_groups_of_people_fully_vaccinated)

cases_by_age_group <- read_csv("data/cases_by_age_group.csv")
View(cases_by_age_group)

# rename
covid_cases <- read_csv("data/cases_by_age_group.csv")
covid_cases

vaccination <- read_csv("data/age_groups_of_people_fully_vaccinated.csv")
vaccination

# remove rows
vaccination <- vaccination[-c(1,2), ]
covid_cases <- covid_cases[-c(1,2), ]
vaccination
covid_cases

# create new columns in vaccination
age_groups <- c('5-11', '12-17', '18-24', '25-39', '40-49', '50-64', '65-74', '75+')

number_of_people <- c('18788369', '44619888', '29859542',
                      '50825458', '28994309', '19527159')
age_groups
number_of_people

vaccination <- cbind(age_groups, number_of_people)
vaccination

# create new columns in covid cases
age_groups_ <- c('5-11', '12-17', '18-39', '40-49', '50-64', '65-74', '75+)





