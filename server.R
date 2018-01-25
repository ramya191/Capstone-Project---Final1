# Shiny server

library(shiny)
library(tm)
library(stringr)
library(markdown)
library(stylo)

quadGram <- readRDS(file="./data/quadGram.rds")
triGram <- readRDS(file="./data/triGram.rds")
biGram <- readRDS(file="./data/biGram.rds")

cleanInput <- function(text){
  textInput <- tolower(text)
  textInput <- removePunctuation(textInput)
  textInput <- removeNumbers(textInput)
  textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
  textInput <- stripWhitespace(textInput)
  textInput <- txt.to.words.ext(textInput, language="English.all", preserve.case = TRUE)
  return(textInput)
}

predictNextWord <- function(numPredictWord, textInput) {
  wordCount <- length(textInput)
  if (wordCount >= 3) { textInput <- textInput[(wordCount-2):wordCount] }
  
  if (length(textInput)==3) {
    word <- as.character(quadGram[quadGram$Word1==textInput[1] & quadGram$Word2==textInput[2] & 
                                    quadGram$Word3==textInput[3],][1:numPredictWord,]$Word4)
    if(is.na(word[1])) {
      word <- as.character(triGram[triGram$Word1==textInput[2] & triGram$Word2==textInput[3],][1:numPredictWord,]$Word3)
      if(is.na(word[1])) {
        word <- as.character(biGram[biGram$Word1==textInput[3],][1:numPredictWord,]$Word2)
      }
    }
  } else if (length(textInput)==2) {
    word <- as.character(triGram[triGram$Word1==textInput[1] & triGram$Word2==textInput[2],][1:numPredictWord,]$Word3)
    if(is.na(word[1])) {
      word <- as.character(biGram[biGram$Word1==textInput[2],][1:numPredictWord,]$Word2)
    }
  } else {
    word <- as.character(biGram[biGram$Word1==textInput[1],][1:numPredictWord,]$Word2)
  }
  return (word)
}

shinyServer <- function (input, output) {
  output$html1 <- renderUI({
    textInput <- input$text1
    textInput <- cleanInput(textInput)
    predictword <- predictNextWord(input$numPredictWord, textInput)  
    
    if (input$numPredictWord==1) {
      str1 <- "Predicted word: "
    } else {
      str1 <- "Predicted words: "
    }
    
    str2 <- ""
    for (i in 1:input$numPredictWord) {
      if(!is.na(predictword[i])) {
        if (i==1) {
          color <- "color:red"
        } else if (i==2) {
          color <- "color:fuchsia"
        } else if (i==3) {
          color <- "color:orange"
        } else if (i==4) {
          color <- "color:lime"
        }  
        predictword[i] <- paste(i, ".", predictword[i])
        str2 <- paste(str2, "<span style=", color, ">", h4(predictword[i], align = "left"), "</span>")
      }
    }
    
    str1 <- h4(str1, align = "left")
    str3 <- h4('Entered text:', align = "left")
    str4 <- paste("<span style='color:blue'>", h4(input$text1, align = "left"), "</span>")
    if (input$displayEnterText==FALSE) {
      str4 <- ""
    }
    HTML(paste(str1, str2, "</br>", str3, str4))
  })
} # end of function(input, output)