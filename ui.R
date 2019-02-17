#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Course-Project-Shiny-Application-and-Reproducible-Pitch"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        selectInput("alcohol", "Alcohol % of Wine:",
            sort(unique(white_wines$alcohol),
                decreasing = FALSE),
            selected = 10.1
            ),
        sliderInput("pH", "pH of Wine:",
            min = 2.72, max = 3.82, value = 3.10, step = 0.01),
        sliderInput("residual.sugar", "Level of residual sugar",
            min = 0.60, max = 65.80,value = 6,95, step = 0.1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h2("Wine Quality Prediction"),
        plotOutput("winePlot"),
        h3("Predicted qualiy of wine as per selected parameters is: "),
        h3(textOutput("result"))
    )
  )
))




