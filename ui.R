library(shiny)
library(tm)
library(SnowballC)
library(wordcloud)
library(plotly)
library(plyr)
set.seed(300)

# Data Pre-processing ----
# Full data set can be downloaded from: 
# https://storage.googleapis.com/kaggle-datasets/636/1222/lyrics.csv.zip

lyrics_train <- read.csv("lyrics_train.csv", header = T, stringsAsFactors = FALSE)
#lyrics_train <- subset(lyrics_train1, year >= 1968 & year <= 2018)


#Define UI ---- 
ui <- fluidPage(
  
  titlePanel("Guidebook for Songwriting: By Genre and Circa"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearInput", "Year", min = 1970, max = 2018, value = c(2010, 2018)),
      selectInput("genreInput", "Genre", choices = c("All","Country","Electronic","Folk",
                                                     "Hip-Hop","Indie","Jazz","Metal"
                                                     ,"Pop","R&B","Rock", "Other")),
      sliderInput("minfreq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 15),
      p("To select the minimum frequency of words"),
      sliderInput("maxwords",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100),
      p("To select the total number of words to be shown"),
      hr(),
      #      actionButton("update", "Change")
      p("Click Go to update!"),
      actionButton("goButton", "Submit"),
      br()
      
      #p("The plot won't update until the button is clicked.",
      #  " Without the use of ", code("isolate()"),
      #  " in server.R, the plot would update whenever the slider",
      #  " changes.")
      
      
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Words used in the songs", h5("Select the year range and music genre to get the words used the most in the lyrics"), plotOutput("WordCloud", width = "100%")),
                  tabPanel("Genre split for the period", h5("Select the year range to see the genre split for that period"), plotlyOutput("Bar", width = "100%")),
                  tags$style(type="text/css",
                             ".shiny-output-error { visibility: hidden; }",
                             ".shiny-output-error:before { visibility: hidden; }")
      )
    )
  ) 
  
)