library(shiny)

shinyUI(fluidPage(
  title = 'Use the DT package in shiny',
  h1('A Table Using Client-side Processing'),
  fluidRow(
    column(2),
    df <- column(3, datatable(head(iris, 20), 
                       extensions = "Buttons",
                       filter = list(position = 'top', clear = FALSE),
                       
                       options = list(
                          regex = TRUE,
                          searchHighlight = TRUE,
                          search = list(regex = TRUE),
                          columnDefs = list(list(className = 'dt-center', targets = 5)),
                          pageLength = 5,
                          lengthMenu = c(5, 10, 15, 20),
                          dom = 'Bfrtip',
                          buttons = c('copy', 'csv', 'excel', 'pdf', 'print', I('colvis')),
                          editor = c('create, edit')
    ))),
    column(2)
  )

  
))
