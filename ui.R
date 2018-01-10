#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("My Dendrogram"),
  
  textOutput("desc"),
  
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
      
      checkboxInput("rotate", "Rotate dendrogram", TRUE), 
      
      textOutput("result")

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tags$a(href = "https://apwi.shinyapps.io/Presentation_my_dendrogram", 
             "Help My Dendrogram", target = "_blank"),
      plotOutput("plotDendrogram"),
      tableOutput("data")
    )
  )
))
