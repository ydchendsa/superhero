library(tm)
library(xtable)
library(dplyr)
library(ggplot2)
library(wordcloud)
dc = read.csv("dc_text.csv")
mdc = read.csv("mdc_clean.csv")
##### creating word cloud for marvel and dc descriptions
Text1<-paste(scan("marvel.txt", what = ' ', sep="\n"), collapse=" ")
Text2<-paste(scan("dc.txt", what = ' ', sep="\n"), collapse=" ")
TEXT<-data.frame(c(Text1,Text2),row.names=c("Text1","Text2"))
TEXT_title<-data.frame(doc_id=row.names(TEXT),text=TEXT$c.Text1..Text2.)
colormap<-rev(brewer.pal(11,'RdYlBu'))
colormap
TEXT_ds<-DataframeSource(TEXT_title)
Corpus<-VCorpus(TEXT_ds)
Corpus<-tm_map(Corpus,removePunctuation)
Corpus<-tm_map(Corpus,tolower)
Corpus<-tm_map(Corpus,removeNumbers)
Corpus <- tm_map(Corpus,stripWhitespace)
Corpus <- tm_map(Corpus,function(x){
  removeWords(x,stopwords())})
Corpus <- tm_map(Corpus,PlainTextDocument)
Term_matrix<-TermDocumentMatrix(Corpus)
Term_matrix<-as.matrix(Term_matrix)
colnames(Term_matrix)<-c("MARVEL","DC")
Data<-data.frame(Term_matrix)
write.csv(Data,'Term_matrix.csv')
#marvel
mar_deswc <- wordcloud(row.names(Data),Data$MARVEL,min.freq=2,col=brewer.pal(8,"Dark2"),rot.per=0.3)
mar_deswc
# dc
dc_deswc = wordcloud(row.names(Data),Data$DC,min.freq=2,col=brewer.pal(8,"Dark2"),rot.per=0.1)
par(mfrow=c(1,1))
comparison.cloud(Data, random.order=FALSE, colors = c("indianred3","lightsteelblue3"),
                  max.words=350)
#Commonality Cloud
library(RColorBrewer)
commonality.cloud(Data, random.order=FALSE, scale=c(5, .5),colors = brewer.pal(4, "Dark2"), max.words=400)


