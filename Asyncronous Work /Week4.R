# Week4

 


info <- function(x){
  a <-mean(x)
  b <-median(x)
  z <-max(x)
  #All others 
  #report the results 
  cat("mean:", a, "\nmedian:", b, "\nmax:", z)
}

Info (v)
quantile(v, 0.5) #the median
quantile(x, 0.75) #numbers above this are top 25%
quantile(x, 0.25) 
#used so they are not impacted by outliars 

#install package to use the function skewness 
install.packages("moments")
library(moments)
skewness(v) #measure of the symetry 

v2 <- c(1,2,2,3,3,3,4,4,4,4,5,5,5,6,6,7,10000)
mean(v2)
hist(v2) #dome-shaped distribution, the middle is the peak of that line 
skewness(v2) 
#to use t-test, data set must have normal distribution, important to know if its normal or not normal 

install.packages("stringr")
library(stringr)
rnorm(20,10,0.1) #will pick random numbers EVERYTIME that follow normal distribution, quantity of numbers, the average, standard deviation (how far numbers are distributed from the mean)
hist(rnorm(20,10,0.1)) #bell shaped distribution, but only used 20 numbers 
hist(rnorm(200,10,0.1)) #bell shaped distribution, better distribution 
hist(rnorm(2000,10,0.1)) #bell shaped distribution, the bigger the sample size, the closer you get to the mean

mean(rnorm(10000,10,2))
skewness(rnorm(20000,10,2)) #skewness goes down the higher the sample size you have, measures the symetry on the distribution, values are closest to mean and least amount of outliars, if skewness was 0, the curve would be a perfect bell shape




#how to replicate
#HW Step 2 

A <- "Head"
B <- "Tail"

RepA <- replicate(100,A)
RepB <- replicate(100,B)

#store results in one bucket 
MyBucket <- c(RepA, RepB)

#Sample function, subset
SamMyBucket <- sample(MyBucket, 10000, replace = TRUE) #putting back so we dont lose number of values 
SamMyBucket

#number of tails in my sample 
TailCount <- length(SamMyBucket[SamMyBucket=="Tail"]) #the number of Tails in SamMyBucket
TailCount
TailPerc <- TailCount / length(SamMyBucket) * 100
TailPerc #will be around 50% because 10k sample size is large 

sam <- function(v,x){
  samp <-sample(v,x, replace=TRUE)
  num <- length(samp[samp=="Tail"])/length(samp) *100
  return(num)
}
sam(MyBucket, 2000) #large sample size gets to large sample size of 50% 

#Quiz **know what skewness is and why use a larger sample size: gets you closer to actual value, average**

#muliple iterations <- mutilple samples and taking the mean of all those means to get rid out outliars 

mean(replicate(100, sam(MyBucket, 100))) #these are 100 averages 
mean(replicate(100, sam(MyBucket, 1000))) #closer to 50%, the law of averages 

x <- mean(replicate(100, sam(MyBucket, 1000)))
Info(x)

#Stepp2 
#Samp.... see full notes at the end of class in recording

#REmove NA rows using the following functions 
DD <- na.omit(D)
#use the following code to replace NA with the mean 
#DataFrame$Column[is.na(DataFrame$Column)]