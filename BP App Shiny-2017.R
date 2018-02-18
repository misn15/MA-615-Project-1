
# Shiny app for Border Apprehensions in 2017

library(shiny)


mydata <- read.csv("PB Apprehensions 2017.csv", header = TRUE, stringsAsFactors = FALSE)

# Define UI for application that draws a barplot
ui <- fluidPage(
  
  # Application title
  titlePanel("Border Patrol Apprehensions along the U.S. Southwest Border in 2017"),
  
  #Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("whatever",
                  "Sector:",
                  choices = mydata$Sector),
      hr(),
      helpText("**Data from U.S. Border Patrol")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a barplot
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    par(mgp=c(3.3, 0.5, 0))
    
    barplot(height = as.matrix(mydata[mydata$Sector == input$whatever, 2:13]), 
            main = input$whatever,
            ylab = "Number of Apprehensions",
            xlab = "Month",
            las=2)
            
    
  })
}


# Run the application 
shinyApp(ui = ui, server = server)


