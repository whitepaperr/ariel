library(tidyverse)

#load data sets 
data2015 <- read.csv("/Users/haeun/git/info201/final-project-umme-kulsum-j/data/world_happiness_report/2015.csv")


# A function that takes in a data set and returns a list of info about it:

summary_info <- list()

#number of rows 
summary_info$num_observations <- nrow(data2015)

#number of columns
summary_info$num_features <- ncol(data2015)

#which country received the maximum happiness score 
summary_info$country_max_score <- data2015 %>%
                                  filter(Happiness.Score == max(Happiness.Score, na.rm = TRUE)) %>%
                                  pull(Country)

#what is the maximum happiness score (throughout all the years)
summary_info$max_score <- data2015 %>%
                          filter(Happiness.Score == max(Happiness.Score, na.rm = TRUE)) %>%
                          pull(Happiness.Score)

#which country received the lowest happiness score 
summary_info$country_lowest_score <- data2015 %>%
                                     filter(Happiness.Score == min(Happiness.Score, na.rm = TRUE)) %>%
                                     pull(Country)


#what is  the lowest happiness score 
summary_info$lowest_score <- data2015 %>%
                             filter(Happiness.Score == min(Happiness.Score, na.rm = TRUE)) %>%
                             pull(Happiness.Score)



