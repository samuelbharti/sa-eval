dtUI <- function(id) {
  ns <- NS(id)
  tagList(
    dataTableOutput(ns("tbl"))
  )
}

dtServer <- function(id, tempdf) {
  moduleServer(id, function(input, output, session) {
    output$tbl <- renderDT({
      # print(tempdf())
      validate(
        need(!is.null(tempdf()), "Please import data."))
      return(
        datatable(tempdf(),extensions = c('Responsive'), 
                  class = 'cell-border stripe',
                  options = list(pageLength = 5,responsive = TRUE)
        )
      )
    })
  })
}
