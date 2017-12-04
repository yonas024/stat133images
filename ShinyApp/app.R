#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(data.table)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(navbarPage("My Application",
                         tabPanel("About",
                                  img(class="img-polaroid", style="display: block; margin-left: auto; margin-right: auto;",
                                      src=paste0("http://content.sportslogos.net/news/2017/07/New-NBA-Logo-Wordmark--350x190.png")),
                                  br(),br(),br(),br(),br(),
                                  div(style="text-align: center;", "Hello my name is yonas")),
                                  
                         tabPanel("Players",
                                  DT::dataTableOutput("players")),
                         tabPanel("Teams",
                                  DT::dataTableOutput("teams")),
                         navbarMenu("More",
                                    tabPanel("Sub-Component A"),
                                    tabPanel("Cars Table"))
                                  ),
                        tags$head(
                          tags$style(HTML("
                                          @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                                          
                                          h1 {
                                          font-family: fantasy;
                                          font-weight: 500;
                                          line-height: 1.1;
                                          color: black;
                                          }
                                          
                                          "))
                          )
                        
                        )

)
              
# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   mydat <- fread("https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv")
   teams = unique(mydat[,2])
   output$players = DT::renderDataTable({DT::datatable(mydat)})
   output$teams = DT::renderDataTable({DT::datatable(teams)})
}

# Run the application 
shinyApp(ui = ui, server = server)

