##  Original GitHub example: at https://github.com/XD-DENG/shiny-authentication ##

library(shiny)
library(magrittr)
user_db <- read.csv("user_db.csv")


#####  Shiny Server side  ####
server <- shinyServer(function(input, output, session) {
  
  current_user_status <- reactiveValues()
  current_user_status$logged <- FALSE
  current_user_status$current_user <- NULL
  current_user_status$access <- NULL
  
  
  output$ui_page_1 <- renderUI({
    
    if(current_user_status$logged == TRUE){
      if("access_to_page_1" %in% current_user_status$access){
        tagList(
          tableOutput("data_1_for_authorized_user")
        )  
      } else {
        tagList(
          div("No access to this part.", style="color:purple")
        )
      }
      
    } else {
      tagList(
        div("Please log in", style="color:red")
      )
    }
    
  })
  
  output$ui_page_2 <- renderUI({
    
    if(current_user_status$logged == TRUE){
      if("access_to_page_2" %in% current_user_status$access){
        tagList(
          tableOutput("data_2_for_authorized_user")
        )  
      } else {
        tagList(
          div("No access to this part.", style="color:purple")
        )
      }
      
    } else {
      tagList(
        div("Please log in", style="color:red")
      )
    }
    
  })
  
  
  output$data_1_for_authorized_user <- renderTable({
    head(iris)
  })
  
  output$data_2_for_authorized_user <- renderTable({
    tail(iris)
  })
  
  
  observeEvent(input$button_login, {
    
    if(input$user!="" && input$password!="" && input$user %in% user_db$id && input$password == user_db$password[user_db$id == input$user]){
      current_user_status$logged <- TRUE
      current_user_status$current_user <- input$user
      current_user_status$access <- user_db[user_db$id == current_user_status$current_user,
                                            c("access_to_page_1", "access_to_page_2")] %>%
        unlist %>% {.==1} %>% names(.)[.]
      
      output$verification_result <- renderText({
        "Login succeeded"
      })
      
    } else {
      current_user_status$logged <- FALSE
      current_user_status$current_user <- NULL
      
      output$verification_result <- renderText({
        "Login failed"
      })
    }
  })
  
  
})


#####  Shiny UI side ####
ui <- fluidPage(
  
  fluidRow(
    column(6, offset=3,
           br(),
           wellPanel(
             textInput("user",
                       "User ID:",
                       width = "70%"),
             passwordInput(inputId = 'password',
                           label = 'Password',
                           width = "70%"),
             
             actionButton("button_login", "Login"),
             br(),
             "Please try 'user1' with password '123' or 'user2' with password '456' to log in.",
             hr(),
             strong(textOutput("verification_result"))
           )
    )
  ),
  
  fluidRow(
    column(8, offset = 2,
           wellPanel(
             uiOutput("ui_page_1")
           ),
           wellPanel(
             uiOutput("ui_page_2")
           )
    )
  )
)

shinyApp(ui = ui, server = server)