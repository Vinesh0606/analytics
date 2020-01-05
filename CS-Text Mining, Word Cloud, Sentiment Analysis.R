#Perform Text Mining on solved eg and then do on the link provided
library(dplyr)
library(ggplot2)
library(tm)
library(wordcloud)
library(SnowballC)  #stopwords
library(tidytext)

fileloc = "https://raw.githubusercontent.com/DUanalytics/datasets/master/text/speech4.txt"
# Load the data as a corpus
document = readLines(fileloc)
document
text = Corpus(VectorSource(document))
text1 <- tm_map(text, stripWhitespace)
text2 <- tm_map(text1, removePunctuation)
text3 <- tm_map(text2, removeWords, stopwords('english'))
text3 #line count
tdm <- TermDocumentMatrix(text3)
tdm
inspect(tdm)
# find words that occur at least four times :
findFreqTerms(tdm, lowfreq = 4)
#identify words are associated with “women” in speech :
findAssocs(tdm, terms = "freedom", corlimit = 0.3)
#save into a matrix
m <- as.matrix(tdm)
#find rowsums
v <- sort(rowSums(m),decreasing=TRUE)
head(v)
wordFreq <- data.frame(word = names(v),freq=v)
head(wordFreq, 10)
#Barplot of words and freq
barplot(wordFreq[1:10,]$freq, las = 2, names.arg = wordFreq[1:10,]$word,col ="lightblue", main ="Most frequent words",  ylab = "Word frequencies")
graphics.off()  #clear all plots
par(mar=c(0,0,0,0))
set.seed(1234)
wordcloud(words = wordFreq$word, freq = wordFreq$freq, min.freq = 1,  max.words=200, random.order=FALSE, rot.per=0.35,  colors=brewer.pal(8, "Dark2"))
#sentiment analysis 
sentiments
#lexicons- AFINN ,bing, loughran
bingSentiments <- get_sentiments("bing")
dim(bingSentiments)
head(bingSentiments)
get_sentiments("bing") %>%  filter(sentiment == "positive")
get_sentiments("bing") %>% group_by(sentiment) %>% tally()
head(wordFreq)
dim(wordFreq)
wordSentiments <- merge(wordFreq, bingSentiments)
#ggplot of Sentiments
wordSentiments %>%  filter(freq > 1) %>% mutate(freq = ifelse(sentiment == "negative", -freq, freq)) %>%  mutate(word = reorder(word, freq)) %>%  ggplot(., aes(x=word, y=freq, fill = sentiment)) +  geom_col() +  coord_flip() +   labs(y = "Sentiment Score") + ggtitle('Sentiment Scores of Words (freq > 1)')


# Load the data as a corpus
fileloc2 = "https://raw.githubusercontent.com/DUanalytics/datasets/master/text/trump_speech.txt"
document2 = readLines(fileloc2)
document2
document2 = readLines(fileloc2)
document2
text = Corpus(VectorSource(document2))
text1 <- tm_map(text, stripWhitespace)
text2 <- tm_map(text1, removePunctuation)
text3 <- tm_map(text2, removeWords, stopwords('english'))
text3
tdm <- TermDocumentMatrix(text3)
tdm
inspect(tdm)
findFreqTerms(tdm, lowfreq = 4)
findAssocs(tdm, terms = "freedom", corlimit = 0.3)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
head(v)
wordFreq <- data.frame(word = names(v),freq=v)
head(wordFreq, 10)
barplot(wordFreq[1:10,]$freq, las = 2, names.arg = wordFreq[1:10,]$word,col ="lightblue", main ="Most frequent words",  ylab = "Word frequencies")
graphics.off()  #clear all plots
par(mar=c(0,0,0,0))
set.seed(1234)
wordcloud(words = wordFreq$word, freq = wordFreq$freq, min.freq = 1,  max.words=200, random.order=FALSE, rot.per=0.35,  colors=brewer.pal(8, "Dark2"))
#sentiment analysis 
sentiments
bingSentiments <- get_sentiments("bing")
dim(bingSentiments)
head(bingSentiments)
get_sentiments("bing") %>%  filter(sentiment == "positive")
get_sentiments("bing") %>% group_by(sentiment) %>% tally()
head(wordFreq)
dim(wordFreq)
wordSentiments <- merge(wordFreq, bingSentiments)
#ggplot of Sentiments
wordSentiments %>%  filter(freq > 1) %>% mutate(freq = ifelse(sentiment == "negative", -freq, freq)) %>%  mutate(word = reorder(word, freq)) %>%  ggplot(., aes(x=word, y=freq, fill = sentiment)) +  geom_col() +  coord_flip() +   labs(y = "Sentiment Score") + ggtitle('Sentiment Scores of Words (freq > 1)')

