#5.8 JSON

install.packages("jsonlite")
library(jsonlite)

install.packages("RCurl")
library("RCurl")

bikeURL <- "https://feeds.citibikenyc.com/stations/stations.json"

install.packages("RJSONIO")
library(RJSONIO)

apiResult <- getURL(bikeURL)
results <- fromJSON(apiResult)
str(results)

results

allBikeData <- results$stationBeanList

str(allBikeData)


allBikeData$id[1]
allBikeData$id[1:10]

#info for first row 
allBikeData[1,]

#average available docks 
mean(allBikeData$availableDocks)

#stations with at least one dock available 
tapply(allBikeData$availableDocks, allBikeData$availableDocks>0, length)

#same as above but different version
docksAvailDF <- allBikeData[allBikeData$availableDocks > 0, ]
nrow(docksAvailDF)

install.packages("RJSONIO")
library(RJSONIO)
results <- fromJSON(apiResult)
results[1]

summary(results[2])

#the number of stations 
allBikeData <- results$stationBeanList
newRows <- length(allBikeData)
newRows

station <- allBikeData[[1]]
station$id

df <- data.frame(matrix(unlist(allBikeData), nrows=815, byrow = T), stringsAsFactors=FALSE)
names(df) <- names(allBikeData[[1]])

sqldf('select AVG(availableDocks) from allBikeData')
library(sqldf)
