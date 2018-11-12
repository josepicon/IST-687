#Writing R Fuctions - How to Build and Test Functions  

MyMode <- function(myVector)
{
  return(myVector)
}

tinyData <- c(1,2,1,2,3,3,3,4,5,4,5)
tinyData

MyMode(tinyData)

MyMode <-function(MyVector)
{
  uniqueValues <- unique(MyVector) #add unique function to MyMode
  return(uniqueValues)
}
MyMode(tinyData) #unique took out redundancies from tinyData

MyMode <- function(myVector)
{
  uniqueValues <- unique(myVector)
  uniqueCounts <- tabulate(myVector)
  return(uniqueCounts)
}

MyMode(tinyData)#returns count of how many times each unique value of tinyData occurs 

MyMode <- function(myVector)
{
  uniqueValues <- unique(myVector)
  uniqueCounts <- tabulate(myVector)
  return(uniqueValues[which.max(uniqueCounts)]) #return the uniqueValue that has the highest uniqueCount associated with it
}
tinyData
MyMode(tinyData) #the most common number in the dataset

tinyData<-c(tinyData,5,5,5)
tinyData
MyMode(tinyData) #now you get 5 bc there's more 5s than 3s in the vector 

tinyData<-c(tinyData,1,1,1)
tinyData
MyMode(tinyData) #tinyData contains 5 1's and 5 5's; however, MyMode function is only returning 1 as the uniqueValue with the highest uniqueCount. which.max returns the first maximum it finds

tinyData<-c(tinyData,9,9,9,9,9,9,9)
tabulate(tinyData)

MyMode <- function(myVector)
{
  uniqueValues <- unique(myVector)
  uniqueCounts <- tabulate(match(myVector,uniqueValues))
  return(uniqueValues[which.max(uniqueCounts)])
}
MyMode(tinyData)

mfv(tinyData)

