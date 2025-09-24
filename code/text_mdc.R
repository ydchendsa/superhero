library(tm)
library(xtable)
library(dplyr)
library(ggplot2)
library(wordcloud)
marvel = read.csv("marvel_text.csv")
dc = read.csv("dc_text.csv")
mdc = read.csv("mdc_clean.csv")
# draw the bar plot for MARVEL VS. DC MPA RATING
mpa_rating = ggplot(data=mdc, aes(entity, ..count..)) + 
  geom_bar(aes(fill = mpa_rating), position = "dodge") +
  scale_fill_brewer(palette="Set1") +
  ggtitle("MARVEL VS. DC MPA RATING") +
  xlab("Publishers") + ylab("Count")
png(file="mpa_rating.png")
print(mpa_rating)
dev.off()


