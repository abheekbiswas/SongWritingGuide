# Data Pre-processing ----
# Full data set can be downloaded from: 
# https://storage.googleapis.com/kaggle-datasets/636/1222/lyrics.csv.zip

lyrics_train <- read.csv("lyrics_train.csv", 
                         header = T, stringsAsFactors = FALSE)
