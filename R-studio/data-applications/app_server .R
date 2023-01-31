library("shiny")
library("dplyr")
library("tidyverse")
library("ggplot2")
library("plotly")
library("rsconnect")

# loading dataset
climate_df<- read.csv("/Users/haeun/git/INFO 201/assignment-4-data-applications-whitepaperr/owid-co2-data.csv")

co2_1750 <- climate_df %>% 
  filter(year == 1750) %>% 
  filter(country == "World") %>% 
  pull(co2)

co2_2020 <- climate_df %>% 
  filter(year == 2020) %>% 
  filter(country == "World") %>% 
  pull(co2)

high_1750 <- climate_df %>%
  filter(year == 1750) %>%
  filter(co2_per_capita == max(co2_per_capita, rm.na = TRUE)) %>%
  pull(country)

low_1750 <- climate_df %>%
  filter(year == 1750) %>%
  filter(co2_per_capita == min(co2_per_capita, rm.na = TRUE)) %>%
  pull(country)

ave_2020 <- round(co2_2020 / 222,digits = 2)

data_description <- list(co2in1750 = co2_1750, co2in2020 = co2_2020, averagein2020 = ave_2020,
                         highin1750 = high_1750, lowin1750 = low_1750)
  
# Define server logic
server <- function(input, output){
  
  plot <- function(country,year){
    dataa <- climate_df %>%
      filter(country %in% input$country) %>% 
      filter(`year` >= input$year[1] & `year` <= input$year[2])
    return(dataa)
  }
  output$chart <- renderPlotly({
    ggplotly(ggplot(plot(input$country & input$year),aes(x= `year`, y= `co2_per_capita`)) +
               geom_point(colour = "blue", size = 1) +
               geom_line() +
               labs(title = input$country, x = "year", y = "CO2 Emission Per Capita"))
  })
}
  
  
  

