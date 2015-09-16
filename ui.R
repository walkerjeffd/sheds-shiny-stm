library(shiny)

shinyUI(fluidPage(
  titlePanel("SHEDS - Stream Temperature Model"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("featureid", label="Feature ID"),
      helpText("Enter a catchment feature id then click Go"),
      submitButton(text = "Go"),
      width = 2
    ),
    mainPanel(
      textOutput("message"),
      dataTableOutput("covariates")
    )
  )
))
