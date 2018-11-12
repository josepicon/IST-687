#5.7 JSON 

#nondiscrete data: remote applications are database "servers" 

#rationale: 

#Data is too large to store in local memory
#data is too large to store on local disk 
#cant make copies of large "system" databases 
#preference that analysis is always current "official" source content vs a copy 

#create a 'MakeGeoURL Function

MakeGeoURL <- function(address){
  root <- "http://maps.google.com/maps/api/geocode/"
  url <- paste(root, "json?address=" ,address, "&sensor=false",sep="")
  return(URLencode(url))
}

MakeGeoURL("1600 Pennsylvania Avenue, Washington, DC")

Addr2latlng <- function(address)
  {
  url <- MakeGeoURL(adresss)
  apiResult <- getURL(url) #send URL to internet 
  geoStruct <- fromJSON(apiResult, simplify = FALSE)
  lat <- NA 
  lng <- NA 
  try(lat <- geoStruct$results[[1]]$geometry$location$lat)
  try(lng <- geoStruct$results[[1]]$geometry$location$lng)
      return(c(lat,lng))
  }
testData <- Addr2latlng("1600 Pennsylvania Avenue, Washington, DC")  

#Acessing Different JSON Data 

#an example using citibike data from NYC 

bikeURL <- "https://www.citibikenyc.com/stations/json"
apiresult <- getURL(bikeURL)
results <- fromJSON(apiresult)
length(results)

#see when the data was generated 
when <- results[[1]]
when

#the next results is actually a list of stations 
stations <- results [[2]]
length(stations)

str(stations[[1]]) 

#Converting from a List to a Dataframe 
numRows <- length(stations)
nameList <- names(stations[[1]])
dfStations <- data.frame(matrix(unlist(stations),nrow = numRows, byrow = T), stringsAsFactors = FALSE)
names(dfStations) <- nameList 

dfStations$availableDocks <- as.numeric(df$availableDocks)
dfStations$availableBikes <- as.numeric(df$availableBikes)
dfStations$availableDocks <- as.numeric(df$totalDocks)


