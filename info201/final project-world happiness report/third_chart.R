library(tidyverse)

happiness_df <- read.csv("/Users/haeun/git/INFO 201/final-project-umme-kulsum-j/data/world_happiness_report/2019.csv")
colnames(happiness_df) <- c("rank", "country", "score", "GDP per capita", "social support", "life expectancy", "freedom", "generosity", "perceptions of gov corruption")

happiness_df <- happiness_df %>%
  filter(rank <= 4 | rank >= 153) %>%
  mutate(order=paste(rank, country)) %>%
  gather(key=factor, value=influence, -rank, -country, -score, -order)

happiness_df$order <- reorder(happiness_df$order, happiness_df$rank)

third_chart <- ggplot(happiness_df, aes(x=factor, y=influence)) + 
  geom_bar(stat="identity", fill=rgb(0.5, 0.70, 0.75)) +
  coord_flip() +
  theme(plot.title=element_text(size=20, face="bold", margin=margin(10,0,10,0))) +
  ggtitle("The Most Influential Factors for Happiness", subtitle="(Top 4 & Bottom 4 Countries in 2019)") +
  ylab("amount of influence in happiness score") +
  xlab("factors") +
  facet_wrap(.~order, ncol=4)