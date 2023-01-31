library("shiny")
library("dplyr")
library("tidyverse")
library("ggplot2")
library("plotly")
library("rsconnect")

# loading dataset
climate_df<- read.csv("/Users/haeun/git/INFO 201/assignment-4-data-applications-whitepaperr/owid-co2-data.csv")

intro_view <- tabPanel(
  "introduction",
  h1("Climate Change"),
  img("", src = "https://pbs.twimg.com/profile_images/688774134856171521/buykfR0Z_400x400.png",
      width = "400", height = "300", align = "center"),
  p("Climate is one of the important factors affecting human life. 
    Among them, carbon dioxide is a major cause of climate change.
    I will analyze how and when carbon dioxide affects which countries through this data."),
  h2("Anaysis"),
  p("The range of the data from 1750 to 2020. In 1750, 9.351 million tons of co2 were emitted.
    In 2020, 34807.259 million tons of co2 were emitted. 
    It can be seen that carbon dioxide emissions have increased significantly in recent years.
    156.79 milltion tons was the average value of co2 across all countries in 2020. 
    Since the population of each country is different, I chose the analyze co2_per_capita.
    Europe has the highest vaule of co2, and World has the lowest value of co2 in 1750."))

chart_view <- tabPanel(
  "trends of co2",
  h1("trends of co2 per country"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "country",label = "Select Country:",
        choices = unique(climate_df$country), selected = NULL
      ),
      sliderInput(
        inputId = "year", label = "Select year:",
        min = 1750, max = 2020, value = c(1750, 2020)
      ),
      h3("Results"),
      p("Not all countries, but most of the countries have increasing amount of co2 emission as time goes by."),
    ),
    mainPanel(
      plotlyOutput("chart")
    )
  )
)

# Define UI
ui <- navbarPage(
  "Climate change",
  theme = shinythemes::shinytheme("cosmo"),
  intro_view,
  chart_view
)
