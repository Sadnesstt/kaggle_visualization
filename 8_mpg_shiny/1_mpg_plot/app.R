pacman::p_load(tidyverse, ggplot2, shiny, Cairo)

ui <- fluidPage(
  headerPanel("Explore MPG data"),
  sidebarLayout(sidebarPanel(
    radioButtons(inputId = "var",
                 label = h3("Variables"),
                 choices = names(mpg)
                 )),
  mainPanel(
    plotOutput('dist')
  ))
)

server <- function(input, output) {
  output$dist <- renderPlot({
    ggplot(data = mpg, aes(!!as.name(input$var))) + geom_bar() + labs(x = "X")
  })
}

shinyApp(ui = ui, server = server)

