library(shiny)
library(tidyverse)

exam <- read_csv("data/Exam_data.csv")

ui <- fluidPage(
  titlePanel("Pupils Examination Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable",
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
      sliderInput(inputId = "bins",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value = 10)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    selected_var <- exam[[input$variable]]
    
    # Ensure the selected variable is numeric
    if(!is.numeric(selected_var)){
      selected_var <- as.numeric(selected_var)
    }
    
    ggplot(data = exam, aes(x = selected_var)) +
      geom_histogram(bins = input$bins,
                     color = "black",
                     fill = "light blue") +
      labs(x = input$variable, y = "Count")
  })
}

shinyApp(ui = ui, server = server)
