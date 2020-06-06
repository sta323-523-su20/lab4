library(shiny)
library(shinythemes) # add a theme: https://rstudio.github.io/shinythemes/
library(tidyverse)
library(dslabs)      # package that contains data - brexit_polls
library(DT)          # fancy data tables: https://rstudio.github.io/DT/

data("brexit_polls")

# Define the user interface
ui <- fluidPage(

    # Application title
    titlePanel(""),

    # Sidebar layout
    sidebarLayout(
        sidebarPanel(
            


        ),

        # Main panel
        mainPanel(

            
        )
    )
)

# Server function
server <- function(input, output) {

    

}

# Run the application 
shinyApp(ui = ui, server = server)
