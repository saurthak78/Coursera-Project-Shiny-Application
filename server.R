#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(caret)
library(ggplot2)

white_wines <- read.csv("D:/R/Work/shiny application/data_products_project/whitewines.csv")

#white_wines <- select(white_wines, c("citric.acid", "residual.sugar",
#    "density", "pH", "sulphates", "alcohol", "quality"))
white_wines <- white_wines %>% mutate_if(is.numeric,funs(factor(.)))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$winePlot <- renderPlot({
        #white_wines <- filter(white_wines, grepl(input$alcohol, alcohol))
        fit <- lm(quality ~ alcohol + pH + residual.sugar, data = white_wines)
        
        pred <- predict(fit,newdata = data.frame(
            residual.sugar = input$residual.sugar,
            pH = input$pH,
            alcohol = input$alcohol))
        #Draw the plot.
        plot <- ggplot(data = white_wines,aes(x = alcohol, y = pH))+
            geom_point(aes(color = residual.sugar), alpha = 0.3)+
            geom_smooth(method = "lm")+
            geom_vline(xintercept = input$alcohol, color = "red")+
            geom_hline(yintercept = pred, color = "green")
        plot
    })
    output$result <- renderText({
        #provides the text output to be displayed under the graph
        white_wines <- filter(white_wines, grepl(input$residual.sugar, residual.sugar),
            grepl(input$pH, pH),
            grepl(input$alcohol, alcohol))
        fit <- lm(quality ~ alcohol + pH + residual.sugar, data = white_wines)
        
        pred <- predict(fit,newdata = data.frame(
            residual.sugar = input$residual.sugar,
            pH = input$pH,
            alcohol = input$alcohol))
        res <- paste(round(pred,digits = 1))
        res
    })
})
