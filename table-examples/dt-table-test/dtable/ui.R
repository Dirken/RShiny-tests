library(shiny)

shinyUI(fluidPage(
  title = 'Use the DT package in shiny',
  h1('A Table Using Client-side Processing'),
  fluidRow(
    column(5, DT::dataTableOutput('x1'))
  )
))
