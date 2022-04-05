module1Tab <-  tabItem(
  tabName = 'module1',
  class = " main", 
  fluidRow(
    column(12,
           HTML("<h5>Task Description:</h5>
           <p>Some description of task and requirements.</p>")
    )),
  hr(),
  fluidRow(
    column(3,
      fileInput('script','Upload your python script (.py)',
                multiple = FALSE, accept = '.py'),
      fileInput('model','Upload your model (.json)',
                multiple = FALSE, accept = '.json'),
      actionButton('loadfiles', label = 'Proceed')
    ),
    column(9,
#           suppressWarnings(add_busy_bar()),
           dataTableOutput('output1'),
           dataTableOutput('output2')
           )
  )
)