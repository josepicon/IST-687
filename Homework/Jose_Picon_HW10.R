install.packages("tidytext")
install.packages("readtext")
install.packages("OptimalCutpoints")
install.packages("tm")
install.packages("wordcloud")
install.packages("ggplot2")
install.packages("slam")
library(tidytext)
library(readtext)
library(OptimalCutpoints)
library(tm)
library(wordcloud)
library(ggplot2)
library(slam)


#Step 1: Read the AFINN word list  

setwd("/Users/josepicon/Desktop")

mlk <- readLines(file("MLK.txt"))
mlk <- mlk[which(mlk != "")] #remove all blank lines in the text

#Create a term matrix
#interprets each element of the "mlk" as a document and create a vector source
words.vec <- VectorSource(mlk)
#create a Corpus
words.corpus <- Corpus(words.vec)
#first step transformation: make all of the letters in "words.corpus" lowercase
words.corpus <- tm_map(words.corpus, content_transformer(tolower))
#second step transformation: remove the punctuation in "words.corpus"
words.corpus <- tm_map(words.corpus, removePunctuation)
#third step transformation: remove numbers in "words.corpus"
words.corpus <- tm_map(words.corpus, removeNumbers)
#final step transformation: take out the "stop" words, such as "the", "a" and "at"
words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))

#create a term-document matrix "tdm",  a "Bag of Words"
tdm <- TermDocumentMatrix(words.corpus)

#Create a list of counts for each word
#convert tdm into a matrix called "m"
m <- as.matrix(tdm)
m[1:10,]

#create a list of counts for each word named "wordCounts"
wordCounts <- rowSums(m)
wordCounts[1:10]

#sum the total number of words and store the value to "totalWords"
totalWords <- sum(wordCounts)
totalWords
#create a vector "words" that contains all the words in "wordCounts"
words <- names(wordCounts)
head(words)

#sort words in "wordCounts" by frequency
wordCounts <- sort(wordCounts, decreasing=TRUE)
#check the first several items in "wordCounts" to see if it is built correctly
head(wordCounts)

#Build Word Cloud
cloudFrame<-data.frame(word=names(wordCounts),freq=wordCounts)
View(cloudFrame)
wordcloud(cloudFrame$word,cloudFrame$freq)

afinn <- read.delim("HW10AFINN.txt", sep = "\t", header = FALSE)
str(afinn)

colnames(afinn) <- c("word", "Score")

#join the df match with AFINN by "word" col in match and "word" col in AFINN 
mergeTable <- merge(cloudFrame, afinn, by.x="word", by.y="word")
str(mergeTable)

#Step 2: Compute	the	overall	score	for	the	MLK	speech using	the	AFINN	word	list	 

length(mergeTable$Score)
mlkOV <- function(){
  a <- mergeTable[1:61, ] #look at values 1 to 20 
  b <- sum(a$freq*a$Score)
  return(b)
}
mlkOV() 


#Step 3: 	compute	the	sentiment	score	for	each	quarter	(25%)	of	the	speech	to	see	how	this	sentiment	analysis	is	the	same	or	different	than	what	was	computing	with	just	the	positive	and	negative	word	files.

mlk1 <- function(){
  a <- mergeTable[1:15,]
  b <- sum(a$freq*a$Score)
  return(b)
}
mlk1()

mlk2 <- function(){
  a <- mergeTable[16:30,]
  b <- sum(a$freq*a$Score)
  return(b)
}
mlk2() 

mlk3 <- function(){
  a <- mergeTable[31:45,]
  b <- sum(a$freq*a$Score)
  return(b)
}
mlk3() 

mlk4 <- function(){
  a <- mergeTable[46:61,]
  b <- sum(a$freq*a$Score)
  return(b)
}
mlk4() 



#step 4: plot and compare results via bar chart

mlkQuarter<- c("1st Quarter","2nd Quarter", "3rd Quarter","4th Quarter")
#you need to insert different results of mlk1 inputs in mlkQuarterScore
mlkQuarterScore <- c(mlk1(),mlk2(),mlk3(),mlk4())
mlkQuarterTotal <- data.frame(mlkQuarter,mlkQuarterScore)

ggplot(mlkQuarterTotal, aes(x=mlkQuarterTotal$mlkQuarter, y=mlkQuarterTotal$mlkQuarterScore)) + geom_bar(stat="identity")+ labs(x="Quarter",y="Sentiment Score",title="Sentiment Score for Each Quarter of MLK Speech")+coord_cartesian(ylim=c(0, 100)) + scale_y_continuous(breaks=seq(0,100,10)) + theme(plot.title = element_text(hjust = 0.5))
