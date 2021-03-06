shinyServer(function(input, output) {
  
  ### Argument names:
  ArgNames <- reactive({
    Names <- names(formals(input$readFunction)[-1])
    Names <- Names[Names!="..."]
    return(Names)
  })
  
  # Argument selector:
  output$ArgSelect <- renderUI({
    if (length(ArgNames())==0) return(NULL)
    selectInput("arg","Argument:",ArgNames())
  })
  
  
  ## Arg text field:
  output$ArgText <- renderUI({
    fun__arg <- paste0(input$readFunction,"__",input$arg)
    
    if (is.null(input$arg)) return(NULL)
    
    Defaults <- formals(input$readFunction)
    
    if (is.null(input[[fun__arg]]))
    {
      textInput(fun__arg, label = "Enter value:", value = deparse(Defaults[[input$arg]])) 
    } else {
      textInput(fun__arg, label = "Enter value:", value = input[[fun__arg]]) 
    }
  })
  
  ### Data import:
  Dataset <- reactive({
    if (is.null(input$file)) {
      # User has not uploaded a file yet
      return(data.frame())
    }
    args <- grep(paste0("^",input$readFunction,"__"), names(input), value = TRUE)
    argList <- list()
    for (i in seq_along(args))
    {
      argList[[i]] <- eval(parse(text=input[[args[i]]]))
    }
    names(argList) <- gsub(paste0("^",input$readFunction,"__"),"",args)
    
    argList <- argList[names(argList) %in% ArgNames()]
    
    Dataset <- as.data.frame(do.call(input$readFunction,c(list(input$file$datapath),argList)))
    return(Dataset)
  })
  
  output$table <- renderD3tf({
    
    # Define table properties. See http://tablefilter.free.fr/doc.php
    # for a complete reference
    tableProps <- list(
      btn_reset = TRUE,
      sort = TRUE,
      sort_config = list(
        # alphabetic sorting for the row names column, numeric for all other columns
        sort_types = c("String", rep("Number", ncol(Dataset())))
      )
    );
    
    d3tf(Dataset(),
         tableProps = tableProps,
         extensions = list(
           list(name = "sort")
           ,
           list( name = "colsVisibility",
                 at_start =  c(8, 9, 10, 11),
                 text = 'Hide columns: ',
                 enable_tick_all =  TRUE
           ),
           list( name = "filtersVisibility",
                 visible_at_start =  TRUE)
         ),
         showRowNames = TRUE,
         filterInput = TRUE,
         edit = TRUE,
         selectableRows = "multi",
         selectableRowsClass = "info",
         tableStyle = "table table-bordered");
  })
  
  
  ### Download csv
  output$downloadSave <- downloadHandler(
    filename = "Rdata.csv",
    content = function(con) {
      assign(input$name, Dataset()[,input$vars,drop=FALSE])
      save(list=input$name, file=con)
    },
    contentType = "text/csv"
  )
  
})
