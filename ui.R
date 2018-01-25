# The user graphic interface definition for Shiny web application.

library(shiny)
library(markdown)

shinyUI <- fluidPage(
  navbarPage("Predict Next Word",
             # multi-page user-interface that includes a navigation bar.
             tabPanel("Application",
                      sidebarLayout(
                        sidebarPanel(
                          textInput(inputId="text1", label = "Please enter your text here: ", value =""),
                          selectInput(inputId = "numPredictWord", label = "Number of predicted word to be displayed: ", selected= 1, choices = c(1,2,3,4)),
                          checkboxInput(inputId="displayEnterText", "Display entered text", value = TRUE)
                        ), # end of "sidebarPanel"
                        mainPanel(
                          htmlOutput("html1")
                        ) # mainPanel
                      ) #sidebarLayout
             ), # end of "Application" tabPanel
             
             tabPanel("Read Me",
                      mainPanel(
                        includeMarkdown("ReadMe.md")
                      ) # mainPanel
             ) # end of "Read Me" tabPanel
             
  ) # end of navbarPage
)
