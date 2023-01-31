library(shiny)
library("dplyr")
library("tidyverse")
library(ggplot2)
library("plotly")


# Loading Dataset
df <- read.csv("/Users/haeun/git/INFO 201/final-project-umme-kulsum-j/data/world_happiness_report/2019.csv")
colnames(df) <- c("rank", "country", "score", "GDP per capita", "social support", "life expectancy", "freedom", "generosity", "perceptions of gov corruption")

intro_view <- tabPanel(
  "Overview",
  img(src='http://worldhappiness.report/assets/images/icons/whr-cover-ico.png', 
      align = "right", style = "width:auto; max-width:45%; padding-left:40px; padding-top:40px"),
  h1("About"),
  p("With the development of many technologies, people have increasingly focused on finding happiness 
    and meaning in life. The desire to live a better life makes people strive to work harder so that 
    they could find happiness through recreation. Since happiness is subjective, we thought it would be 
    interesting to see what generally makes people happier. That is why we will be pulling data from 
    the World Happiness Report."),
  h2("World Happiness Report"),
  p("The World Happiness Report is a publication of the United Nations Sustainable Development Solutions Network. 
    The report contains scores and rankings of national happiness, based on data collected from individuals in over 150 countries.
    The report also correlates with various factors that contribute to quality of life.
    This report primarily uses data from the Gallup World Poll."),
  h2("Exploration of Variables Impacting Happiness Scores"),
  h3("1. Generosity"),
  p("Generosity is the residual of regressing national average of response to the GWP question 
    “Have you donated money to a charity in the past month?” on GDP per capita.
<<<<<<< HEAD
    Therefore we chose to look at the distribution of generosity across all countries."),
  h3("2. GDP per Capita"),
  p("GDP can have an immense impact on people's happiness, so we chose to look at the correlation between GDP and happinesss scores."),
  h3("3. Most Influential Factors Among Countries"),
  p("For our final exploration, we chose to compare the amount of influence thatdifferent factors have on happiness scores."),
  h2("Group Members"),
  p("Allyson Graylin, Ha Eun Lee, Sirena Akopyan, Umme-Kulsum Darugar"))

chart1_view <- tabPanel(
  "Generosity Levels",
  h1("Generosity Distribution Based on Perceptions of Corruption"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "choices",
        label = "Pick Corruption Level",
        choices = list("Low" = "low", "Medium" = "medium", "High" = "high"),
        selected = "don't select"
      )
    ),
    mainPanel(
      plotlyOutput(""),
      tableOutput("")
    )
  )
)

chart2_view <- tabPanel(
  "GDP vs Happiness",
  h1("Relationship between GDP and Happiness rate"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "GDP",label = "GDP level",
        min = 0.0, max = 1.7, value = c(0.0,1.7)
      ),
      h2("Results"),
      p("In 2019, the higher the GDP, the higher the happiness score.")
    ),
    mainPanel(
      plotlyOutput("chart2")
    )
  )
)

chart3_view <- tabPanel(
  "Happiness Factors",
  h1("Comparing the Influence of Factors on Happiness"),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        inputId = "countries",
        label = "Select Countries:",
        choices = df$country,
        multiple = TRUE,
        selected = c("Finland", "Denmark", "Afghanistan", "South Sudan")
      ),
      h3("Results"),
      p("In 2019, social support & GDP per capita contributed to about 40% of Finland and Denmark's happiness score but only about 30% of Afghanistan and South Sudan's score."),
      h3("Analysis"),
      p("From this graphic, we can see a general trend in the most happy and least happy countries. Although the bottom countries may not have as strong of a trend, we can see that the most influential factors across countries are typically social support, GDP per capita, and life expectancy.")
    ),
    mainPanel(
      plotlyOutput("chart3"),
      br(),
      tableOutput("chart3_table")
    )
  )
)

summary_view <- tabPanel(
  "Summary"
)

# Define UI
shinyUI(navbarPage(
  "Analaysis of World Happiness",
  theme = shinythemes::shinytheme("cosmo"),
  intro_view,
  chart1_view,
  chart2_view,
  chart3_view,
  summary_view,
  footer = tags$footer(HTML("<div>Created by Allyson Graylin, Ha Eun Lee, Sirena Akopyan, & Umme-Kulsum Darugar | 12/8/2021</div>"), 
                       align = "center", style = "position:fixed; bottom:0; width:100%; height:35px; 
                padding:5px; color:white; background-color:black;")
))
