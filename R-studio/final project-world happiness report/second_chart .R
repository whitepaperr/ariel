library("dplyr")
library("ggplot2")
library("tidyverse")

# Load the data
happiness <- read.csv("/Users/haeun/git/INFO 201/final-project-umme-kulsum-j/data/world_happiness_report/2019.csv")

#Create the chart
second_chart <- ggplot(data = happiness, aes(x= GDP.per.capita, y= Score)) +
     geom_point(colour = "blue", size = 1) +
    labs(title = "GDP per capita vs. Happiness Score", x = "GDP per capita" , y = "Happiness Score")
