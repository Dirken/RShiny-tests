library(shiny)
library(DT)

shinyServer(function(input, output, session) {
  x <- DT::datatable(iris, 
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
                         buttons = c('copy', 'csv', 'excel', 'pdf', 'print', I('colvis'))
                       ))
  
  output$x1 = DT::renderDataTable(x, selection = 'none', server=TRUE)
  

  
  proxy = dataTableProxy('x1')
  
  observeEvent(input$x1_cell_edit, {
    info = input$x1_cell_edit
    str(info)
    i = info$row
    j = info$col
    v = info$value
    x[i-1, j-1] <<- DT:::coerceValue(v, x[i, j])
    replaceData(proxy, x, resetPaging = FALSE)
  })

})