#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(lubridate)
library(data.table)

dengue1 <-read.csv("Dengue2012-2015.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$data_table <- renderTable({
    dg1 <- as.data.table(dengue1)

    dyear <- as.character(input$yyear)

    if (dyear == "2012"){
      # Return first 30 rows
      dg1 <- dg1[dg1$Year =="2012"]
      head(dg1, 30)}
    else if (dyear == "2013"){
      dg1 <- dg1[dg1$Year =="2013"]
      head(dg1, 30)}
    else if (dyear == "2014"){
      dg1 <- dg1[dg1$Year =="2014"]
      head(dg1, 30)}
    else{
      dg1 <- dg1[dg1$Year =="2015"]
      head(dg1, 30)}
  })  
  
  output$distPlot <- renderPlot({

    # Bar chart
    ggplot(dengue1,  aes(x = Year, fill=State) )  +   geom_bar() + xlab("Year") + ylab("Total Cases") +
      ggtitle("Dengue overview")
    
  })
  
  
  output$distScatter <- renderPlot({
    
    #Filter dataset by chosen Year, then by State
    dengueScatter.filter_year<-dengue1[dengue1$Year==input$yyear,]
    dengueScatter.filter_State<-dengueScatter.filter_year[dengueScatter.filter_year$State==input$select_State,]

    #Customize graph title name according to parameters
    title1 <- paste(input$yyear, sep = " ", 'Dengue total outbreak cases in Malaysia' )
    title2 <- paste(title1, sep = " - ", input$select_State )
      
    ggplot(data=dengueScatter.filter_State, aes(x=dengueScatter.filter_State$Week, y=dengueScatter.filter_State$Outbreak_Duration)) + geom_jitter(color="darkred") + labs(title=title2, x="Week No",y="Outbreak Duration")
  
  })  
  
})