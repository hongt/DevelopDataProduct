#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

choices = list("Johor", "Kelantan", "Melaka", 
               "N. Sembilan", "P.Pinang",  "Pahang", "Perak", "Perlis", "Sabah",
               "Sarawak", "Selangor", "Terengganu", "WPKL")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("2012-2015 Malaysia Dengue Outbreak"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(h3('Github URL'),
                 h5('https://github.com/hongt/DevelopDataProduct'),
                 h1(' '),
                 h5('Tab panel Overview Dengue Table Data(30 rows) - Choose Year in Slider below'),
                 h5('Tab panel PLOT DENGUE Cases Barchart - Overall of State and Year overview ONLY'),
                 h5('Tab panel PLOT DENGUE Outbreak ScatterPlot  - Choose Year in Slider below and then choose State in Tab Panel'),                 
       sliderInput("yyear",
                   "Year:",
                   min = 2012,
                   max = 2015,
                   value = 1,sep = "")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overview Dengue Table", tableOutput("data_table")),
        tabPanel("PLOT DENGUE Cases Barchart", plotOutput("distPlot")),
        tabPanel("PLOT DENGUE Outbreak ScatterPlot",  tabPanel("Panel1", selectInput("select_State", h3("Select State"),
                                         choices  ) ), 
                                         plotOutput("distScatter")))
    
    )    
  )
))
