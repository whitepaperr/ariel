library(shiny)
library("dplyr")
library("tidyverse")
library(ggplot2)
library("plotly")


# Loading Dataset
df <- read.csv("/Users/haeun/git/INFO 201/final-project-umme-kulsum-j/data/world_happiness_report/2019.csv")
colnames(df) <- c("rank", "country", "score", "GDP per capita", "social support", "life expectancy", "freedom", "generosity", "perceptions of gov corruption")

# Define server logic
shinyServer(function(input, output) {
  # Chart 1: Generosity Distribution
  

  # Chart 2: GDP vs Happiness
  plot <- function(GDP) {
    dataa <-  df %>%
      filter(`GDP per capita` >= input$GDP[1] & `GDP per capita` <= input$GDP[2])
    return(dataa)
  }
  
  output$chart2 <- renderPlotly({
    ggplotly(ggplot(plot(input$GDP),aes(x= `GDP per capita`, y= `score`)) +
               geom_point(colour = "blue", size = 1) +
               labs(title = "GDP per capita vs. Happiness Score", x = "GDP per capita" , y = "Happiness Score"))
  })
  
  # Chart 3: Happiness Factors
  barchart_table <- function(countries) {
    country_table <- df %>%
      filter(country %in% input$countries) %>%
      mutate(label=paste(rank, country)) %>%
      gather(key=factor, value=influence, -rank, -country, -score, -label)
    
    country_table$label <- reorder(country_table$label, country_table$rank)
    return(country_table)
  
  output$chart3 <- renderPlotly({
    ggplotly(ggplot(barchart_table(input$countries), aes(x=factor, y=influence)) + 
               geom_bar(stat="identity", fill=rgb(0.5, 0.70, 0.75)) +
               coord_flip() +
               ggtitle("The Most Influential Factors for Happiness (2019)") +
               ylab("amount of influence in happiness score") +
               xlab("factors") +
               facet_wrap(.~label))
  })
  
  output$chart3_table <- renderTable({
    df[df$country %in% input$countries,]
  })
  }
})
