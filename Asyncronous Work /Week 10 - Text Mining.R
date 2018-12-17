#Ch 10: Text Mining 

mlk <- readLines(file("MLK.txt"))

#remove all blank lines in text 
mlk <- mlk[which(mlk != "")]

#create term matrix 
#interprets each element of the "mlk" as a document and create a vector source 
words.vec <- VectorSource(mlk)

#create a corpus,
words.corpus <- Corpus(words.vec)

#first step transformation: make all of the letters in "word.corpus" lowercase 
words.corpus <- tm_map(words.corpus, content_transformer(tolower))

#second step: remove punctuations in "word.corpus" 
words.corpus <- tm_map(words.corpus, removePunctuation) 

#third step: remove numbers 
words.corpus <- tm_map(words.corpus, removeNumbers)

#final step: take out the "stop" words, such as "the", "a", and "at"
words.corpus <- tm_map(words.corpus, removewords, stopwords("english"))

#create a term-document matrix "tdm" 
tdm <- TermDocumentMatrix(words.corpus)

#view term-docuemtn matrix 
tdm 

#convert tdm into a matrix 
m <- as.matrix(tdm)
m[1:10,]

#create a line of counts for each word named "wordCounts"
wordCounts <- rowSums(m)
wordCounts[1:10]

#sum the total number of words and stroe the value to "total words" 
totalwords <- sum(wordCounts)
totalwords

#create a vector "words" that contain all the words in "wordCounts"
words <- names(wordCounts)

#sort 
wordCounts <- sort(wordCounts, decreasing=TRUE)

#build word clloud 

#Step 1: Sentiment / Affinity Score 

afinn <- read.delim("###", sep = "\\t", header = FALSE)
str(afinn)

colnames(afinn) <- c("word", "Score")

#join the df match with AFINN by "word" col in match and "word" col in AFINN 
mergeTable <- merge(cloudFrame, afinn, by.x="word", by.y="word")
str(mergeTable)

#Step 2: 

mlkl <- funcion(){
  a <- mergedTable[1:20, ] #look at values 1 to 20 
  b <- sum(a$freq*a$Score)
  return(b)
}
mlkl() #the affininity score for the terms above are the output of this, change the numbers "1:20" and call it with different values to see what you get, change the inputs to it can pull from 1st and second row to see how the speech changed over time 

#step 5: plot and compare results 

ggplot(mlkQuarter)