# This app accepts an html file and a csv of all the captions (the csv should have a header!)
#


library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Swap Captions in HTML"),
  
  # Sidebar   
  sidebarLayout(
    sidebarPanel(
      
      h6("This app takes the html file of a module, with caption placeholders done. Please
you the CaptionR app to identify how many captions to put on each slide before pulling the 
html. Note: This app searches for the phrase REPLACEMEWITHTEXT when swapping captions.
         Then accepts a csv of all the captions. It repeatedly replaces the placeholder 
         text with the corresponding caption (position-wise). If there are any errors, 
         it is best to simply re-upload the original html file to Lectora, then re-check
         placeholders and run the app again."),
      
      ## Select a file --- ,
      fileInput("the.html","Select the html file",
                multiple = FALSE,
                accept = ".html",
                buttonLabel = "Browse"),
      h6("Please check the caption file and make sure the count is equal to the count from the 
         table. If there are blank rows, that means the storyboard had errant line breaks. 
         If you stick to exactly what the table says, then the blanks should stay."),
      h6("NOTE: fix pending.  apostrophes in captions become a black diamond. should be uncommon."),
      fileInput("the.captions","Select the captions file from CaptionR",
                multiple = FALSE,
                accept = ".csv",
                buttonLabel = "Browse"),
      
      actionButton(inputId = "submit",label = "Run Program")
      ),
    
    # Main Panel
    mainPanel(
      textOutput("done")
    )
      )
  ))
