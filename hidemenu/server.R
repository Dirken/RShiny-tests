
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

server <- shinyServer(function(input, output, session) {
  observeEvent(input$txtbx,{
    if (input$txtbx == "") return(NULL)
    hide(id = "greetbox-outer", anim = TRUE)
    print(input$txtbx)
  })
})