library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Estimate gas consumption of a vehicle"),
    sidebarPanel(
        numericInput('Weight', 'Please enter vehicle weight (kg):',value = 2000, min = 1000, max = 6000, step = 50), 
        #br(),
        numericInput('Horsepower', 'Please enter horsepower:',value = 150, min = 50 , max = 500, step = 50),
        #br(),
        radioButtons('Cyl', label = h3("Choose number of cylinders"), choices = list("4 cylinders" = 1, "5 cylinders" = 2, "6 cylinders" = 3, "8 cylinders" = 4), selected = 1)),
    #br(),
    #submitButton("Submit"),
    mainPanel(
        tabsetPanel(
            tabPanel("Documentation", verbatimTextOutput("summary")),
            tabPanel("Calculation", 
                     h3("Predicted Gas Consumption (mpg):"),
                     textOutput('text'),
                     h3("Predicted Gas Consumption (litres per 100 km):"),
                     textOutput('text2'),
                     h3("Here is where the predicted consumption fits (red dot):"),
                     plotOutput("plot1"))
            
        )
            )
))