module2Tab <-  tabItem(
  tabName = 'module2',
  class = "", 
  fluidRow(
    column(12,
      h3('Bioinformatics Evaluation'),
      p('Functional analysis'))
  ),
  hr(),
  fluidRow(
    column(6,
           includeMarkdown("taskModules/bioinformatics/functionalAnalysis.Rmd")
    ),
    column(6,
           
           a(href="dd/bi/queryGeneList_BI_functionalAnalysis.txt", h5("Download gene list"), download=NA, target="_blank"),
           hr(),
           radioButtons("bi-fa-ident", label = "Please select your method of identification:",
                        choices = list("EnrichR (focus on significant pathways)" = "bi-fa-ident-1",
                          "EnrichR + custom code (focus on significant pathways)" = "bi-fa-ident-2",
                          "EnrichR (focus on significant pathways + disease relevance)" = "bi-fa-ident-3",
                          "EnrichR + custom code (focus on significant pathways + disease relevance)" = "bi-fa-ident-4")),
           br(),
           HTML("<h5>Submit your list of significantly enriched terms. Use a newline for each term</h5>"),
           br(),
           fileInput('bi-fa-upload','Upload your gene list. (.txt)',
                     multiple = FALSE, accept = '.txt'),
           actionButton('bi-fa-submit', label = 'Submit')
           )
  )
)