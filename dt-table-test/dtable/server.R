library(shiny)
library(DT)

shinyServer(function(input, output, session) {
  output$tbl_a = DT::renderDataTable(iris, server = TRUE)
})