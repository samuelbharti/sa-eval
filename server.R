# Define server logic required to draw a histogram
auth0_server(  
  
  function(input, output, session) {
    
    userName <- session$userData$auth0_info$nickname
  
    intern_meta_user <- intern_meta[intern_meta$Username == userName,]
    Usr.FirstName <- intern_meta_user$FirstName
    Usr.LastName <- intern_meta_user$LastName
    Usr.Email <- intern_meta_user$Email
    Usr.Pathway <- intern_meta_user$Pathway
    Usr.Title <- intern_meta_user$Title
    
    
    
    output$pathwayMod <- reactiveVal(Usr.Pathway)
    
    output$userDetails <- renderUI({
      
      div(style = "text-align:left",
          class="ml-4 align-items-center",
          HTML(paste0("<h5>Hi ",  Usr.FirstName,", here are your details:</h5>")),
          HTML(paste0("<p>
                       User Name: ", userName,"</br>
                       Full Name: ", Usr.FirstName," ",Usr.LastName,"</br>
                       Email: ", Usr.Email,"</br>
                       Pathway: ", Usr.Pathway ,"</p>"
                      ))
      )
    })
    
    
    output$user <- renderUser({
      dashboardUser(
        name = userName,
        image = paste0("https://github.com/",userName,".png"),
        title = intern_meta_user$Title,
#        subtitle = "Intern",
        footer = p(class = 'text-center',
          logoutButton())  
        # fluidRow(
        #   dashboardUserItem(
        #     width = 6,
        #     "Item 1"
        #   ),
        #   dashboardUserItem(
        #     width = 6,
        #     "Item 2"
        #   )
        # )
      )
    })
    
  output$user_Info <- renderPrint({
    paste0("Welcome ",session$userData$auth0_info$nickname)
  })
  output$credential_Info <- renderPrint({
    session$userData$auth0_credentials
  })
  
  df.result <- eventReactive(input$loadfiles, {
    
    #    req(input$script, input$name, input$model)
 #   print('entered here')
    
#    print(input$name)
    
    # validate(
    #   need(input$in1, 'Check at least one letter!'),
    #   need(input$in2 != '', 'Please choose a state.')
    # )
    
    model_size <- file.size(input$model$datapath)/1024
    
    print(model_size)
    
    print(input$script$datapath)
    #    source_python
    # import submission predict module and time
    start_time <- proc.time()[[3]]
    #input$script$datapath
    #predict <- 
    source_python(input$script$datapath)
    end_time <- proc.time()[[3]]
    script_time <- end_time - start_time
    print(script_time)
    
    
    print(input$model$datapath)
    #print(input$model$name)
    #    print(predict)
    start_time <- proc.time()[[3]]
    preds <- py_predict(test_data,input$model$datapath)
    end_time <- proc.time()[[3]]
    predict_time <- end_time - start_time
    print(predict_time)
    
    #    print(label$price)
    return(data.table(UserName = userName, Preds = preds, Label = label$price,script_time =
                        script_time,predict_time = predict_time, model_size = model_size))
    
  })
  
  output$output1 <- renderDT({
    scores <- df.result()
    datatable(scores,extensions = c('Responsive'), 
              class = 'cell-border stripe',
              options = list(pageLength = 5,responsive = TRUE)
    )
  })
  
  
  
  output$output2 <- renderDT({
    
    scores <- df.result()
    print(head(scores))
    #    UserName <- input$name
    
    # use RMSE from Metrics (sqrt(mean((data$actual - data$predicted)^2))) to score 
    scores[,RMSE := rmse(Label,Preds),by=.(UserName)]
    
    # one score per user 
    scores <- scores[,.SD[1],by=.(UserName)][,.(UserName,RMSE)]
    
    # for demo purposes, image we had another 100 submissions with 100 randomly drawn RMSEs
    scores <- rbindlist(list(scores,data.table(UserName = paste('User',1:99,sep = '_'),RMSE = rnorm(99,179,20))))
    
    # add decile to show Grouping, lower is better 
    scores[,Decile_RSME := cut(RMSE,
                               breaks = quantile(RMSE, probs = 0:10/10),
                               labels = 1:10, right = T,include.lowest = T)]
    
    #print(x)
    datatable(scores,extensions = c('Responsive'), 
              class = 'cell-border stripe',
              options = list(pageLength = 5,responsive = TRUE)
    )
    
  })
  }, info = a0_info
)