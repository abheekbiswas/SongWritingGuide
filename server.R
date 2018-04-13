#Define Server logic ----
server <- function(input, output){
  
  output$WordCloud <- renderPlot({
    input$goButton
    isolate({
      
      # Wordcloud Generate - Train ----
      ifelse(input$genreInput == "All", lyrics_train_subset <- subset(lyrics_train, year >= input$yearInput[1] & year <= input$yearInput[2]),
             lyrics_train_subset <- subset(lyrics_train, year >= input$yearInput[1] & year <= input$yearInput[2] & genre == input$genreInput))
      
      lyrics_train_corpus <- Corpus(VectorSource(lyrics_train_subset$lyrics))
      lyrics_train_corpus <- tm_map(lyrics_train_corpus, PlainTextDocument)
      lyrics_train_corpus_clean <- tm_map(lyrics_train_corpus, tolower)
      lyrics_train_corpus_clean <- tm_map(lyrics_train_corpus_clean, removeNumbers)
      lyrics_train_corpus_clean <- tm_map(lyrics_train_corpus_clean, removeWords, stopwords("english"))
      lyrics_train_corpus_clean <- tm_map(lyrics_train_corpus_clean, removePunctuation)
      lyrics_train_corpus_clean <- tm_map(lyrics_train_corpus_clean, stripWhitespace)
      #lyrics_train_corpus_clean <- tm_map(lyrics_train_corpus_clean, stemDocument)
      
      wordcloud(lyrics_train_corpus_clean, min.freq = input$minfreq, max.words = input$maxwords, rot.per = .35, 
                random.order = F, colors = brewer.pal(8, "Dark2"), scale = c(5,0.5))
    })
  })
  
  output$Bar <- renderPlotly({
    input$goButton
    isolate({
      lyrics_train_gen <- subset(lyrics_train, year >= input$yearInput[1] & year <= input$yearInput[2])
      
      lyrics_train_gen$genre[lyrics_train_gen$genre == "Not Available"] <- "Other"
      
      lyrics_train_gen_table <- count(lyrics_train_gen, 'genre')
      
      plot_ly(lyrics_train_gen_table, labels = ~genre, values = ~freq, type = 'pie', textposition = 'outside', textinfo = 'label+percent', sort=T) %>% layout(title = paste("Genre split for the years",input$yearInput[1], "-", input$yearInput[2]))
      
      
    }
    
    )
  }
  
  )
  
  }