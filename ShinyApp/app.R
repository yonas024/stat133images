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
mydat <- fread("https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv")

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(navbarPage("NBA",
                         tabPanel("About",
                                  img(class="img-polaroid", width=400, height=250,style="display: block; margin-left: auto; margin-right: auto;",
                                      src="http://www.pngmart.com/files/5/NBA-Transparent-Background.png"),
                                  br(),br(),br(),br(),br(),
                                  div(style="text-align: center;", "")),
                                  
                         tabPanel("Players",
                                  DT::dataTableOutput("players")),
                         tabPanel("Teams",
                                  DT::dataTableOutput("teams")),
                         navbarMenu("More",
                                    tabPanel("References",
                                             div(class = "titles", style="text-align: center;", "References"),
                                             br(),br(),br(),br(),
                                             tags$ul(
                                               tags$li("https://shiny.rstudio.com/articles/layout-guide.html"),
                                               tags$li("https://stat.ethz.ch/R-manual/R-devel/library/base/html/unique.html"),
                                               tags$li("http://rstudio.github.io/shiny/tutorial/#run-and-debug"),
                                               tags$li("https://shiny.rstudio.com/articles/css.html"),
                                               tags$li("https://developer.mozilla.org/en-US/docs/Web/CSS/font-family") 
                                             )),
                                    tabPanel("Github",
                                             div(class = "titles",style="text-align: center;", "Github"),
                                             br(),br(),br(),br(),
                                             div(style="text-align: center;", tags$a(href="https://github.com/yonas024", "Click here to go to my github!"))),
                                    tabPanel("Facebook",
                                             div(class = "titles",style="text-align: center;", "Facebook"),
                                             br(),br(),br(),br(),
                                             div(style="text-align: center;", tags$a(href="https://www.facebook.com/yotukb", "Click here to go to my facebook!"))),
                                    tabPanel("Email",
                                             div(class = "titles",style="text-align: center;", "Email"),
                                             br(),br(),br(),br(),
                                             div(style="text-align: center;", "kbromyonas@gmail.com"))
                                  )),
                        tags$head(
                          tags$style(HTML("
                                          
                                          .titles {
                                          font-family: cursive;
                                          font-size: 50px;
                                          line-height: 1.1;
                                          color: black;
                                          }

                                          body {
                                          background-color: #1E90FF
                                          }

                                          .navbar {
                                          background-color: black
                                          }
                                          
                                          "))
                          )
                        
                        )

)
              
# Define server logic required to draw a histogram
server <- function(input, output) {
   
   teams = unique(mydat[,2])
   output$players = DT::renderDataTable({DT::datatable(mydat)})
   output$teams = DT::renderDataTable({DT::datatable(teams)})
}

# Run the application 
shinyApp(ui = ui, server = server)

