#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dbscan)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cluster Dendrogram"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      fileInput("file1", "Choose CSV File for matrix data",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv") ),
      checkboxInput("header", "CSV file with Header", TRUE),  
      checkboxInput("display", "Display data", FALSE), 
      textOutput("name"),
      textOutput("size"),
      
      tags$hr(),
      
      selectInput( "method", "Choose a cluster method:",
                   list( `Single-Link`   = c("single"),
                         `Complete-Link` = c("complete"),
                         `Average-Link`  = c("average"),
                         `Median-Link`   = c("median"),
                         `Centroid-Link` = c("centroid") ) ),
      
      selectInput( "metric", "Choose a distance metric:",
                   list( `Euclidian` = c("euclidean"),
                         `Manhattan` = c("manhattan"),                       
                         `Minkowski` = c("minkowski"),
                         `Binary`    = c("binary") ) ),
      
      numericInput( "dim", "Minkowski dimension", value=1 ),
      
      checkboxInput("rotate", "dendrogram rotate", FALSE), 
      
      textOutput("result")

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plotDendrogram"),
      tableOutput("data")
    )
  )
))
