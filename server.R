#setwd("C:/Users/Vedrana/Desktop/dokumenti/education/The Data Science Specialization/Course 9 - Data Products/PA shiny/")
library(shiny)
library(UsingR)
library(ggplot2)
shinyServer(  
  function(input, output) {
        output$newHist <- renderPlot({
         # conversion because of cm or inches
         k <- as.numeric(input$measure=="cm")*2.54 + as.numeric(input$measure=="inch")
         galton2 <- galton*k
         
         # model
         model = lm(formula = child ~ parent, data = galton2)
         p <-  (as.numeric(input$hF) + 1.08*as.numeric(input$hM))/2
         c <- predict(model, data.frame(parent = p))
         
         # For plotting             
         inData <- data.frame(parent=p, child = c)
         gm <- min(rbind(galton2,inData))
         gM <- max(rbind(galton2,inData))
         
         ggplot() + 
           geom_point(data = galton2, aes(x=parent,y=child), color = "blue",   alpha=0.2,size=3) +
           geom_point(data = inData,  aes(x=parent,y=child), color = "red", alpha=0.9,size=5) +
               labs(x = "Parent\'s height", y = "Child\'s height", title ="LM prediction using Galton\'s dataset") + 
              coord_cartesian(xlim = c(gm-5,gM+5), ylim = c(gm-5,gM+5)) +
          geom_smooth(data = galton2, aes(x=parent,y=child),method='lm') + 
           geom_hline(data=inData,yintercept=inData$c, color = "red", linetype = "dashed") +
          guides(color = FALSE, fill = FALSE) 
         }, 
         height = 280, width = 450)
       
       output$prediction <- renderText({
          k <- as.numeric(input$measure=="cm")*2.54 + as.numeric(input$measure=="inch")
          galton2 <- galton*k
       
          # model
          model = lm(formula = child ~ parent, data = galton2)
          p <-  (as.numeric(input$hF) + 1.08*as.numeric(input$hM))/2
          c <- predict(model, data.frame(parent = p))
          return(c)
       })
  }
)