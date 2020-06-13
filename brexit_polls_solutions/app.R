library(shiny)
library(shinythemes)
library(tidyverse)
library(dslabs)
library(DT)

data("brexit_polls")

pollsters <- brexit_polls %>% 
    count(pollster) %>% 
    pull(pollster) %>% 
    as.character()

# Define the user interface
ui <- fluidPage(theme = shinytheme("yeti"),

    # Application title
    titlePanel("Brexit Polls Explorer"),

    # sidebar
    sidebarLayout(
        sidebarPanel(
            
            dateRangeInput(inputId = "daterange",
                           label   = "Enter poll start range",
                           start   = "2016-01-08",
                           end     = "2016-06-23",
                           min     = "2016-01-08",
                           max     = "2016-06-23"),
            
            selectInput(inputId  = "pollster",
                        label    = "Select pollster",
                        choices  = pollsters)

        ),

        # main panel
        mainPanel(
           plotOutput(outputId = "plotpolls"),
           dataTableOutput(outputId = "tablepolls")
        )
    )
)

# Create server function
server <- function(input, output) {

    output$plotpolls <- renderPlot({
        brexit_polls %>% 
            filter(startdate >= input$daterange[1], 
                   startdate <= input$daterange[2]) %>% 
            filter(pollster == input$pollster) %>% 
            ggplot(aes(x = startdate, y = remain)) +
            geom_point(aes(color = "blue"), size = 2) +
            geom_line(aes(color = "blue")) +
            geom_point(aes(y = leave, color = "red"), size = 2) +
            geom_line(aes(y = leave, color = "red")) +
            labs(x = "Poll's starting date", y = "Proportion") +
            theme_minimal(base_size = 20) +
            theme(legend.position = "bottom") +
            scale_color_identity(name   = "Brexit Decision",
                                 breaks = c("blue", "red"),
                                 labels = c("Remain", "Leave"),
                                 guide  = "legend")
    })
    
    output$tablepolls <- DT::renderDataTable({
        brexit_polls %>% 
            filter(startdate >= input$daterange[1], 
                   startdate <= input$daterange[2]) %>% 
            filter(pollster == input$pollster) %>% 
            arrange(startdate)
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
