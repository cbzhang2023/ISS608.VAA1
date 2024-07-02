pacman::p_load(shiny, shinydashboard, shinythemes, scatterPlotMatrix, parallelPlot,
               cluster, factoextra, tidyverse)

whitewine <- read.csv("data/wine_quality.csv") %>%
  filter(type == "white") %>%
  select(c(1:11))

print(whitewine)

ui <- navbarPage(
  title = "ShinyIDEA: Interactive Data Exploration and Analysis",
  fluid = TRUE,
  theme= shinytheme("flatly"),
  id = "naybarID",
  tabPanel("Introduction"),
  navbarMenu("Univariate"),
  navbarMenu("Bivariate"),
  navbarMenu("Multivariate",
             tabPanel("Scatter",
                      sidebarLayout(
                        sidebarPanel(width = 3,
                                     selectInput("corrPlotTypeSelect",
                                                 "Correlation Plot Type:",
                                                 choices = list(
                                                   "Empty" = "Empty",
                                                   "Circles" = "Circles",
                                                   "Text" = "Text",
                                                   "AbsText" = "AbsText"),
                                                 selected = "Text"),
                                     selectInput("distType",
                                                 "Distribution Representation:",
                                                 choices = list("Histogram" = 2,
                                                                "Density Plot" = 1),
                                                 selected = 1)
                        ),
                        mainPanel(width = 9,
                                  box(
                                    scatterPlotMatrixOutput("spMatrix",
                                                            height = "500px",
                                                            width = "650px")
                                  )
                        )),
                      tabPanel("Optimal No. of Clusters"),
                      tabPanel("Kmeans Clustering"))
  )
)



server <- function(input, output) {
  # Shiny Server: Scatter Plot Matrix
  output$spMatrix <- renderScatterPlotMatrix({
    scatterPlotMatrix(whitewine,
                      distribType = input$distType,
                      corrPlotType = input$corrPlotTypeSelect,
                      rotateTitle = TRUE
    )
  })
  
  # Shiny Server: Determining The Optimal Number Of Clusters
  output$optimalPlot <- renderPlot({
    # The actual content for the plot should be defined here.
    # This could include calculations and visualizations related to finding the optimal number of clusters.
  })
  
  # Shiny Server: Visual k-means Clustering
  output$parallelPlot <- renderPlot({
    # Here, you should include the code that creates a parallel coordinate plot for k-means clustering.
    # Typically, this might involve running a clustering algorithm on your data and then plotting the results.
  })
}

shinyApp (ui = ui, server = server)