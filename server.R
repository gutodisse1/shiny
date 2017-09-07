
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  sampleData = read.table("dados.csv", header=T, sep=";")
  
  
  # UI
  output$selectX<-renderUI({
    selectInput("dynamicX", "Variável X",
                choices = names(sampleData)
    )
  })
  
  output$selectY<-renderUI({
    selectInput("dynamicY", "Variável Y",
                choices = names(sampleData)
    )
  })
  
  output$selectG<-renderUI({
    selectInput("dynamicG", "Tipo de gráfico",
                choices = list("Dispersão" = "plot", "Barras" = "bar", "Pizza" = "pie", "Histograma" = "hist"),
                selected = "Dispersão"
    )
  })
  
  #
  # REACTIVE
  #
  d <- reactive({
    
    switch(input$input_num_I,
           column <- c(which( colnames(sampleData)==input$dynamicX )),
           column <- c(which( colnames(sampleData)==input$dynamicX ),which( colnames(sampleData)==input$dynamicY ))
    )
    X <- sampleData[,column]
    
    return(X) 
  })
  
  # TABLE
  output$tableSet <- renderTable({d()})
  
  # SUMMARY
  output$valueSummary <- renderPrint( summary( d() ) )
  
  # PLOT
  output$valueI <- renderPrint({ input$input_num_I })
  output$valueY <- renderPrint({ input$dynamicX })
  output$valueX <- renderPrint({ input$dynamicY })
  output$valueG <- renderPrint({ input$dynamicG })
  
 
  output$plot <- renderPlot({
    if(is.null(input$dynamicG))
    { return() }
    switch(input$dynamicG,
           plot = plot(d(),pch=19 , cex=10 , col=rgb(sampleData[,which( colnames(sampleData)==input$dynamicX )]/max(sampleData[,which( colnames(sampleData)==input$dynamicX )]),0.5,1,0.4)),
           pie  = pie(d()),
           hist = hist(d(), main=input$dynamicX, xlab=input$dynamicX, col=rgb(0.3,0.5,1,0.4)),
           bar = barplot(as.matrix(d())))
  })
  
})
