#WORLD HAPPINESS ON A MAP
library(dplyr)
library(tidyverse)
library(ggplot2)
#2019 World Happiness Dataset
wh <- read_csv('/Users/haeun/git/info201/final-project-umme-kulsum-j/data/world_happiness_report/2019.csv')
View(wh)
histogram <- ggplot(wh, aes(x=Generosity)) + 
  geom_histogram(binwidth=.1, color="black", fill="lightblue") + 
  labs(title="Generosity Distribution", y="Number of Countries")
print(histogram)
