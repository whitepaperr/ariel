library(tidyverse)
library(data.table)

#load data
data2015 <- read.csv("/Users/haeun/git/INFO 201/final-project-umme-kulsum-j/data/world_happiness_report/2015.csv")

#group by region
data2015 <- data2015 %>%
            group_by(Region) %>%
            summarise(Average.Happiness.Score = round(mean(Happiness.Score),digits=3)) %>%
            arrange(desc(Average.Happiness.Score))

data_table <- setDT(data2015)