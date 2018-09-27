library(shiny)
library(shinyjs)

# Get table metadata. For now, just the fields
# Further development: also define field types
# and create inputs generically

####  Part 1:  Define Data Input/Output Build & Operations  ####
## Function #1 to Create a Container for Fields ##
GetTableMetadata <- function() {
  fields <- c(id = "Id", 
              name = "Name", 
              used_shiny = "Used Shiny", 
              r_num_years = "R Years")
  result <- list(fields = fields)
  return (result)
}

# Find the next ID of a new record
# (in mysql, this could be done by an incremental index)

## Function #2 to Report Next Row ID ####
GetNextId <- function() {
  if (exists("responses") && nrow(responses) > 0) {
    max(as.integer(rownames(responses))) + 1
  } else {
    return (1)
  }
}

##Function # 3 to Create Data to Populate the MetaData Table ####
CreateData <- function(data) {
  
  data <- CastData(data)
  rownames(data) <- GetNextId()
  if (exists("responses")) {
    responses <<- rbind(responses, data)
  } else {
    responses <<- data
  }
}

## Function #4  to Read the Data to Create a Simple Table ####
ReadData <- function() {
  if (exists("responses")) {
    responses
  }
}

## Function #5 to Update the Data Assigned to a Table ####
UpdateData <- function(data) {
  data <- CastData(data)
  responses[row.names(responses) == row.names(data), ] <<- data
}

## Function #6 to Delete the Data Assigned to a Table ####
DeleteData <- function(data) {
  responses <<- responses[row.names(responses) != unname(data["id"]), ]
}

## Additional  Customized Function #7 to Write the Assigned Data to a Table ####
# Cast from Inputs to a one-row data.frame
CastData <- function(data) {
  datar <- data.frame(name = data["name"], 
                      used_shiny = as.logical(data["used_shiny"]), 
                      r_num_years = as.integer(data["r_num_years"]),
                      stringsAsFactors = FALSE)
  
  rownames(datar) <- data["id"]
  return (datar)
}


#### Part 2: Assigned New Data to a Table ####
CreateDefaultRecord <- function() {
  mydefault <- CastData(list(id = "0", name = "", used_shiny = FALSE, r_num_years = 2))
  return (mydefault)
}

# Fill the input fields with the values of the selected record in the table
UpdateInputs <- function(data, session) {
  updateTextInput(session, "id", value = unname(rownames(data)))
  updateTextInput(session, "name", value = unname(data["name"]))
  updateCheckboxInput(session, "used_shiny", value = as.logical(data["used_shiny"]))
  updateSliderInput(session, "r_num_years", value = as.integer(data["r_num_years"]))
}

####  UI for CRUD App using customized DM functions from above ####
ui <- fluidPage(
  #use shiny js to disable the ID field
  shinyjs::useShinyjs(),
  
  #data table
  DT::dataTableOutput("responses", width = 300), 
  
  #input fields
  tags$hr(),
  shinyjs::disabled(textInput("id", "Id", "0")),
  textInput("name", "Name", ""),
  checkboxInput("used_shiny", "Used Shiny", FALSE),
  sliderInput("r_num_years", "R Years", 0, 25, 2, ticks = FALSE),
  
  #action buttons
  actionButton("submit", "Submit"),
  actionButton("new", "New"),
  actionButton("delete", "Delete")
)

####  Part 3: Server for CRUD App, using customized DM functions from Part 1 ####
server <- function(input, output, session) {
  
  # input fields are treated as a group
  formData <- reactive({
    sapply(names(GetTableMetadata()$fields), function(x) input[[x]])
  })
  
  # Click "Submit" button -> save data
  observeEvent(input$submit, {
    if (input$id != "0") {
      UpdateData(formData())
    } else {
      CreateData(formData())
      UpdateInputs(CreateDefaultRecord(), session)
    }
  }, priority = 1)
  
  # Press "New" button -> display empty record
  observeEvent(input$new, {
    UpdateInputs(CreateDefaultRecord(), session)
  })
  
  # Press "Delete" button -> delete from data
  observeEvent(input$delete, {
    DeleteData(formData())
    UpdateInputs(CreateDefaultRecord(), session)
  }, priority = 1)
  
  # Select row in table -> show details in inputs
  observeEvent(input$responses_rows_selected, {
    if (length(input$responses_rows_selected) > 0) {
      data <- ReadData()[input$responses_rows_selected, ]
      UpdateInputs(data, session)
    }
    
  })
  
  # display table
  output$responses <- DT::renderDataTable({
    #update after submit is clicked
    input$submit
    #update after delete is clicked
    input$delete
    ReadData()
  }, server = FALSE, selection = "single",
  colnames = unname(GetTableMetadata()$fields)[-1]
  )     
}


# Shiny app with 3 fields that the user can submit data for
shinyApp(ui = ui, server = server)

####  Data File ####
#View(responses)
