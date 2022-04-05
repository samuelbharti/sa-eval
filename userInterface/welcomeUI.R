welcomeTab <-  tabItem(
  tabName = 'welcome',
  class = " main", 
    fluidRow(
      column(12,
             tags$img(src = "img/STEM_Away.png",class="img-fluid")
      )
    ),
   hr(),
   fluidRow(
     column(6,
            uiOutput('userDetails')
            ),
     column(6,
            div(style = "text-align:justify",
                class="text-center align-items-center",
            HTML("<h5>About SA-EVAL App</h5>
                 <p>Some description here about the app or some other kind of descriptive content for welcome page. </p>"),
            actionButton('begin', label = 'Go to evaluation tasks ')
            )
   ))
)