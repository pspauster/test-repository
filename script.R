library(tidyverse)

#read in my data from API
temp_hsg_api <- read_csv("https://data.cityofnewyork.us/resource/jiwc-ncpi.csv")

#OR read in my data from file
temp_hsg_file <- read_csv("data/Local_Law_79_2022_-_Temporary_Housing_Assistance_Usage_20231211.csv")

#OR and only IF it's too big, instructions to download and read in
# download 311 data https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9
# save it as 311.csv in the data folder
temp_hsg_large_file <- read("data/311.csv")

temp_hsg_api %>% 
  mutate(date = lubridate::ym(data_period),
         children = as.integer(str_replace(total_children, ",", ""))) %>% 
  filter(agency == "Department of Homeless Services (DHS)", category == "Total number of individuals utilizing city-administered facilities", facility_or_program_type == "DHS-administered facilities") %>%
  ggplot()+
  geom_line(mapping = aes(x=date, y = children))

#I can also save my output here if I want
ggsave("output/children_in_shelter.svg")
