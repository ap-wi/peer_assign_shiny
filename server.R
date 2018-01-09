#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library( shiny )
library( stats )
library( tidyverse )
library( sets )
library( ggdendro )
library( ggplot2 )

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plotDendrogram <- renderPlot({
    
    inFile <- input$file1
    
    if (is.null(inFile)) {
      ## name
      l_name <- "test data"
      ## test data
      my_data <- data.frame( x = c( 2, 4, 5, 3, 1, 9, 7, 6, 8 ),
                             y = c( 6, 9, 6, 2, 7, 5, 4, 1, 2 ) )
      rownames(my_data) <- c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine" )
    } else {
      ## name
      l_name <- paste0( "file : ", inFile$name )
      ## read csv-file with matrix     
      my_data <- read.csv( inFile$datapath, header=input$header )
    } 

    output$name <- renderText( l_name )
    
    l_text <- paste0( "size: ", nrow(my_data) )  
    output$size <- renderText( l_text )
    
    if ( input$display == TRUE ) { 
      output$data <- renderTable( my_data, rownames = TRUE)
    } else {
      output$data <- renderText( paste0("") )
    }
  
    ## generate cluster dendogram based on input$metric and input$method
    mat.dist <- stats::dist( x=my_data, method=input$metric, p=input$dim )
    ## generate hierarchical     
    h.clust   <- stats::hclust( mat.dist, method=input$method )
    ggdendro::ggdendrogram( h.clust, rotate=input$rotate, size=5, theme_dendro = TRUE )
    
  })
  
})
