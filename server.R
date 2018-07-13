

# Define server logic 
shinyServer(function(input,output,session) {
  
  
  observeEvent(
    eventExpr = input[["submit"]],
    handlerExpr = {
      print("Running")
    }
  )
  
  # this starts once the "submit" button as been hit
  output$done <- eventReactive(input$submit,{ 
    
    #input the uploaded files
    inhtml <- input$the.html
    incsv <- input$the.captions
    # read it from its location [NOTE: uploaded files create a data frame of columns: name,size, type, datapath]  in datapath 
    
    # each of the above have an object name and a datapath to reading the file itself
    
    #read the html and the csv 
    
    .html <- readLines(inhtml$datapath, warn = FALSE) 
    .captions <- read.csv(incsv$datapath,  # read the data
                          stringsAsFactors = FALSE)
    
    .captions <- .captions[,2]  # just the 2nd column has captions
    
    if(.captions[1] == "Captions.in.Order"){ # if the first row is the header
    .captions <- .captions[-1] # take that out
    }
    
    # if a caption doesn't have any letters in it, replace those captions with an obvious error. 
    
    letter.checker <- function(x){
      if(grepl("[a-z]",x) == FALSE)
        x <- "error please delete this caption"
      return(x)
    }
  .captions <- sapply(.captions,        # if an errant blank space was put in 
                      letter.checker,   # it will fill the caption with a sentence for error 
                      USE.NAMES = FALSE)  # best practice
  
  
    #replace loopwise 
  index.of.captions <- grep("REPLACEMEWITHTEXT",.html)  #get the rows of all the captions in the html
  if(length(index.of.captions) != length(.captions)){
    return("there are an unequal number of captions, please check both files")
  }
  for(i in 1:length(index.of.captions)){
    #get an index of the caption index  
    curr.index <- index.of.captions[i]   #move along the index of the index 
    
    #replace the relevant html with its captions counterpart 
    .html[curr.index] <- sub("REPLACEMEWITHTEXT",.captions[i],.html[curr.index])
    
  }
 
   
    # rewrite the html with a new name 
    write(.html, file = paste0(inhtml$name[1],   # put the name back 
                               "-with captions",  # add this 
                               ".html"))         # type of file is html 
    
    
    return("process complete, please check for errors.")
  })
  
  #remove the 4#'s later 
  #session$onSessionEnded(function() {
  #  stopApp()
  #  q("no")
  #})
})








