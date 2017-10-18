
# header ------------------------------------------------------------------

# My first shiny app


# clear R's brain ---------------------------------------------------------

rm(list = ls())

# load libraries ----------------------------------------------------------

library(shiny)
library(tidyverse)


# load data ---------------------------------------------------------------

kpi_db <- read_csv(file = "data/KPI_scores_database_2017-10-18.csv")

kpi_db_gi1 <- kpi_db %>% 
    filter(idIBC == 270)

ui <- fluidPage(
    
    dateInput(inputId = "date",
              label = "Pick a date.",
              value = "2017-10-17",
              min = "2017-01-01",
              max = "2017-10-17",
              weekstart = 1
              ),
    plotOutput("bar")
)

server <- function(input, output) {
    
    output$bar <- renderPlot({
        
    kpi_db_gi1 %>% 
            filter(date == input$date) %>% 
            mutate(kpi_score == as.factor(kpi_score)) %>% 
            
            ## make plot
            
            ggplot(aes(x = KPI_name, y = kpi_score)) +
            geom_bar(stat = "identity") +
            coord_flip()
        
    })
}

shinyApp(ui = ui, server = server)

