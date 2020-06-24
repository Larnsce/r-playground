

library(ggplot2)


ui <- fluidPage(
    selectInput("var", "Variable", choices = names(diamonds)),
    numericInput("min", "Minimum", value = 1),
    tableOutput("output")
)

server <- function(input, output, session) {
    data <- reactive(filter(diamonds, .data[[input$var]] > input$min))
    output$output <- renderTable(head(data()))
}

shiny::shinyApp(ui = ui, server = server)