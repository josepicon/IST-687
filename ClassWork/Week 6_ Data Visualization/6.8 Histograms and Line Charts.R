#6.8 Histograms and Line Charts 

install.packages("ggplot2")
library(ggplot2)

mtc <- mtcars
ggplot(mtc,aes(x=mpg)) + geom_histogram(bins=5)

g <- ggplot(mtc,aes(x=mpg)) + geom_histogram(bins=5, color="black", fill="white")

g + ggtitle("mpg buckets")

g <- ggplot (mtc, aes(x=mpg)) +geom_histogram(binwidth = 10, color="black", fill="white")
g <- ggplot (mtc, aes(x=mpg)) +geom_histogram(binwidth = 2, color="black", fill="white")
g <- ggplot (mtc, aes(x=mpg)) +geom_histogram(binwidth = 15, color="black", fill="white")
g
