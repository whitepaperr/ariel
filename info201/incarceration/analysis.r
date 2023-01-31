library("dplyr")
library(ggplot2)
library("tidyverse")
library("maps")
library("mapproj")

# use read.csv() to store the data
incarceration <- read.csv("/Users/haeun/git/INFO 201/assignment-3-incarceration-whitepaperr/incarceration_trends.csv")

# What are the columns in the data?
feature_names <- colnames(incarceration)

# What counties are there in the data?
county_names <- incarceration%>%
  select(county_name)%>%
  unique(na.rm = TRUE)

# How many observations are in the data?
num_of_ob <- nrow(incarceration)

# What are the range of years in the data?
range_of_year <- incarceration%>%
  select(year)%>%
  range(na.rm =TRUE)

# For the most recent year, how many people are in jail, prison, and total pop?
num_data_stat <- incarceration %>%
  group_by(year)%>%
  filter(total_prison_pop > 0 )%>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE),
    total_jail_pop = sum(total_jail_pop, na.rm = TRUE),
    total_pop = sum(total_pop, na.rm = TRUE))%>%
  filter(year == max(year))
  
jail_pop <-  num_data_stat%>%
  pull(year, total_jail_pop)

prison_pop <- num_data_stat%>%
  pull(year, total_prison_pop)

total_pop <- num_data_stat%>%
  pull(year, total_pop)

total_pop_without_year <- num_data_stat%>%
  pull(total_pop)

total_incarcerated <- num_data_stat%>%
  select(total_jail_pop, total_prison_pop)%>%
  summarize(inccarcerated = total_jail_pop + total_prison_pop)

recent_year <-num_data_stat%>%
  pull(year)

# Data description
data_description <- list( observations = num_of_ob, year = range_of_year, 
  jail = jail_pop, prison = prison_pop, total = total_pop,
  total_pop_no_year = total_pop_without_year, total_incarcerated_pop = total_incarcerated,
  recent_year = recent_year)

# Chart 1
incarceration_time <- incarceration%>%
  group_by(year)%>%
  mutate(total_incarceration_number = replace_na(total_jail_pop + total_prison_pop, 0))%>%
  mutate(wihte_incarceration_number = replace_na(white_jail_pop + white_prison_pop, 0))%>%
  mutate(black_incarceration_number = replace_na(black_jail_pop + black_prison_pop, 0))%>%
  mutate(latinx_incarceration_number = replace_na(latinx_jail_pop + latinx_prison_pop, 0))%>%
  mutate(aapi_incarceration_number = replace_na(aapi_jail_pop + aapi_prison_pop, 0))%>%
  mutate(native_incarceration_number = replace_na(native_jail_pop + native_prison_pop, 0))%>%
  summarize(across(total_incarceration_number:native_incarceration_number, sum, na.rm = TRUE))%>%
  pivot_longer( cols = -year,  names_to =  "RACE" )%>%
  filter(year >= 1980 & year <= 2016)

incarnation_time_trend <-  incarceration_time %>%
  mutate(RACE = factor(RACE, levels = c(
    "total_incarceration_number", "black_incarceration_number", "wihte_incarceration_number", 
    "latinx_incarceration_number", "aapi_incarceration_number", "native_incarceration_number")))

incarceration_over_time_plot <- ggplot(data = incarnation_time_trend) +
  geom_point(mapping = aes(x = year, y = value, color = RACE))+ 
  geom_line(mapping = aes(x = year, y = value, color = RACE))+
  scale_color_brewer(palette = "Dark2") +
  labs(title = "Incarcerated Population Over Time", x = "year" , y = "Incarcerated population")

# Chart 2
top_10_black_incarceration <- incarceration %>%
  mutate(total_black_incarceration_pop = replace_na(black_prison_pop, 0 ) + replace_na(black_jail_pop, 0),
    total_incarceration_pop = replace_na(total_jail_pop, 0) + replace_na(total_prison_pop, 0))%>%
  filter(year == "2016" )%>%
  group_by(state)%>%
  summarize(total_black_incarceration_pop = sum(total_black_incarceration_pop, na.rm = TRUE),
    total_incarceration_pop = sum(total_incarceration_pop, na.rm = TRUE),
    total_pop_for_15to64 = sum(total_pop_15to64, na.rm = TRUE),
    total_black_pop_for_15to64 = sum(black_pop_15to64, na.rm = TRUE))%>%
  mutate(total_rate = (total_incarceration_pop / total_pop_for_15to64))%>%
  mutate(black_rate = (total_black_incarceration_pop / total_black_pop_for_15to64))

get_top_10_state <- top_10_black_incarceration %>%
  select(state, total_rate, black_rate)%>%
  slice_max(black_rate, n = 10)%>%
  arrange(black_rate)

data_for_to_10 <- get_top_10_state %>%
  pivot_longer(cols = -state, names_to = "rate" )%>%
  mutate(state_order = factor(state, levels = get_top_10_state$state))

top_10_black_incarceration_plot <- ggplot(data = data_for_to_10) +
  geom_col(mapping = aes(y = value, x = state_order, fill = rate), 
           position = position_dodge2(reverse = TRUE)) +
  coord_flip() +
  scale_fill_manual(values = c("black", "red"), labels = c(black_rate = "black", total_rate = "total")) +
  labs( title = "States with Highest Rate of Black Incarceration", y = "Percent Incarcerated",
    x = "State" ) 

# Chart 3
racial_incarceration_discrepancy_map <- incarceration %>%
  filter(year == "2016")%>%
  mutate(black_pop = replace_na(black_jail_pop, 0) + replace_na(black_prison_pop, 0))%>%
  mutate(white_pop = replace_na(white_jail_pop, 0) + replace_na(white_prison_pop, 0))%>%
  mutate(black_rate_for_map = (black_pop / black_pop_15to64))%>%
  mutate(white_rate_for_map = (white_pop / white_pop_15to64))%>%
  mutate(ratio_black_white = (black_rate_for_map / white_rate_for_map))

state_shape <- map_data("county") %>%
  mutate(polyname = paste0(region, ",", subregion)) %>%
  left_join(county.fips)

state_shape[state_shape$polyname == "washington,pierce" , "fips"] <- 53053
state_shape[state_shape$polyname == "washington,san juan" , "fips"] <- 53055

filter_for_wa <- state_shape%>%
  filter(region == "washington")%>%
  left_join(racial_incarceration_discrepancy_map, by = "fips")

racial_incarceration_discrepancy_map_plot <- ggplot(filter_for_wa) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = ratio_black_white)) +
  coord_map() +
  scale_fill_distiller(palette = "Purples", trans = 'reverse') +
  theme(axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank()) +
  labs(fill = "ratio of black:white",
    title = "Discrepancies between racial incarceration rates in WA",
    caption = "Displays the ratio of black incarceration rate to white incarceration rate. A ratio of 2.0 
    means that black people are twice as likely to be incarcerated as white people.")



