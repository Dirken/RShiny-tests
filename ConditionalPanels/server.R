
library(shiny)

shinyServer(function(input, output) {

  output$frontEnd <- renderUI(
    fluidPage(
      input$buton,
      conditionalPanel(condition = "input.buton == 0",p("I'm a form")),
      conditionalPanel(condition = "input.buton > 0", p("I'm a dashboard"))
    )
  )
})
