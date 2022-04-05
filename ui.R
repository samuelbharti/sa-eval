source('userInterface/welcomeUI.R')
source('userInterface/moduleUI.R')
source('userInterface/moduleUI2.R')


sidebar <- dashboardSidebar(
  skin = "light",
  sidebarMenu(id = "tabs",
              menuItem("Welcome", tabName = "welcome", 
                       icon = icon("arrow-right")),
              bs4SidebarHeader("Task Modules"),
              bs4SidebarMenuItem("Module 1", tabName = "module1",
                       icon = icon("upload")),
                       #condition = "output.pathwayMod == 'Bioinformatics'"),
              menuItem("module 2", tabName = "module2",
                       icon = icon("project-diagram")),
              # menuItem("Module 3", tabName = "module3", 
              #          icon = icon("object-group")),
              # bs4SidebarMenuItem("Module 4", tabName = "module4", 
              #          icon = icon("chart-bar")
              #          ),
              menuItem("Result", tabName = "result", 
                       icon = icon("download")),
              bs4SidebarHeader("Help"),
              menuItem("FAQs", icon = icon("question-circle"), tabName = "faq"),
              menuItem("About STEM-Away", tabName = "contact", icon = icon("users"))
  )
)

body <- dashboardBody(
  tabItems(
    welcomeTab,
    module1Tab,
    module2Tab
  )
  ,
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
  tags$script(JS("setTimeout(function(){history.pushState({}, 'Page Title', '/');},2000);"))
  )
)





title <- dashboardBrand(
  title = HTML("<h5 class = 'mt-1'>SA-EVAL App</h5>"),
 # title = "SA-EVAL App",
  color = "info",
  href = "https://stemaway.com/",
  opacity = 1,
  image = "img/logo.png"
)




auth0_ui(  
  
  # Dashboard UI
  
  dashboardPage(
    freshTheme = create_theme(
      bs4dash_vars(
        navbar_light_color = "#040404"
      ),
      bs4dash_layout(
        main_bg = "#edf2e9" 
          #"#fffffc" 
      ),
      bs4dash_sidebar_light(
        bg = "#edf2e9",
        color = "#040404",
        hover_color = "#0C4767",
      ),
      bs4dash_status(
        primary = "#436377", danger = "#BF616A", success = '#2a9d8f', warning = '#F7B538', info = "#edf2e9"
      ),
      #    success = '#57A773'
      #    2a9d8f
      #90bc8c
      bs4dash_color(
        blue = '#4281A4', 
        lime = '#EBEBEB',
        white = '#edf2e9'
      )
    ),
    dashboardHeader(
      fixed = TRUE,
      border = TRUE,
      status = 'info',
      rightUi  =  userOutput("user"),
      sidebarIcon = shiny::icon("water"),
      title = title,
      div(style = "margin-left:auto;margin-right:auto; text-align:center; color:black",
          HTML('<h6 class="text-bold">STEM-Away Application Screening and Evaluation Platform</h6>'))
    ),
    sidebar,
    body,
    #controlbar = dashboardControlbar(),
    footer = dashboardFooter(),
    fullscreen = TRUE, dark = NULL
  )
  
  , info = a0_info
)