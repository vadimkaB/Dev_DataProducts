library(UsingR)
data(Cars93)

shinyServer(
    function(input, output) {
        model <- lm(MPG.city ~ Horsepower + Cylinders + Weight, data = Cars93)
        df <- data.frame(a= numeric(0), b= character(0), c = numeric(0))
        colnames(df)<- c("Horsepower","Cylinders","Weight")
        df[,2] <- factor(df[,2], levels = c(4,5,6,8))
        dfBox <- subset(Cars93, Cylinders %in% c("4", "5", "6", "8"))
        dfBox$Cylinders <- droplevels(dfBox$Cylinders)
        pred <- reactive({
            hp <- input$Horsepower
            wt <- input$Weight
            cyl <- input$Cyl
            df[1,1] <- hp
            df[1,2] <- 4*(cyl == 1)+5*(cyl == 2)+6*(cyl == 3)+8*(cyl == 4)
            df[1,3] <- wt
            predict(model, newdata = df)
        })
        
        output$text <- renderText({pred()
        })
        output$text2 <- renderText({-0.6119835616*pred()+24.07517808
        })
        output$plot1 <- renderPlot({
            est <- pred()*c((input$Cyl == 1),(input$Cyl == 2),(input$Cyl == 3),(input$Cyl == 4))
            boxplot(MPG.city ~ Cylinders, data = dfBox, col = "lightgreen", main = "MPG.city vs. Horsepower", xlab = "Cylinders",  ylab = "MPG.city")
            points(1:4, est, pch=16, col="red", cex = 2)
        })
        output$summary <- renderText("This app calculates projected gas consumption as function of horsepower, number of cylinders and vehicle weight. 
Please enter those parameters in the respective fields on the left and app will do the calculations. 
The big red point n the chart will demonstrate how your selection compares to the population. 
                                     Thank you!")
    }
)