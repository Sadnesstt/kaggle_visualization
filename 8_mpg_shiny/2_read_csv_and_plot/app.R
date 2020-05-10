pacman::p_load(tidyverse, ggplot2, shiny, Cairo)

ui <- fluidPage(
  headerPanel("Explore data"),
  sidebarLayout(sidebarPanel(
    fileInput('file', h3("Enter your Data File"), accept = c("text/csv","text/comma-separated-values, text/plain",".csv")),
    uiOutput('radio')
  ),
  mainPanel(
    plotOutput('dist')
  ))
)

server <- function(input, output) {
    
    filedata <- reactive({
      inFile <- input$file
      
      if (is.null(inFile)) {
        # User has not uploaded a file yet
        return(NULL)
      }
      
      read.csv(inFile$datapath)
    })
  
  output$radio <- renderUI({
    df <- filedata()
    if(is.null(df)) return(NULL)
    items <- names(df)
    radioButtons('var', h3("Variables"), choices = items)
  })
  
  observeEvent(input$var, {
    df <- filedata()
    output$dist <- renderPlot({
      ggplot(data = df, aes(!!as.name(input$var))) + geom_bar() + labs(x = "X")
    })
  })
}
  
shinyApp(ui = ui, server = server)