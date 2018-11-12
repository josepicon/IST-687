#JSON & tapply: Accident Analysis 

install.packages("RCurl")
install.packages("RJSONIO")
install.packages("sqldf")
install.packages("jsonlite")
install.packages('curl')

library("RCurl")
library("RJSONIO")
library("sqldf")
library("jsonlite")
library("curl")

#Step 1: Load the data 

link <- 'https://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD'
JSONInput <- fromJSON("https://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD")
JSONData <- JSONInput$data #make into a datafrom 
MyData <- data.frame(JSONData)

#Step 2: Clean the data
MyData
MyData <-MyData[,-1:-8]
colnames(MyData) <-namesOfColumns <-c("CASE_NUMBER","BARRACK","ACC_DATE","ACC_TIME","ACC_TIME_CODE","DAY_OF_WEEK","ROAD","INTERSECT_ROAD","DIST_FROM_INTERSECT","DIST_DIRECTION","CITY_NAME","COUNTY_CODE","COUNTY_NAME","VEHICLE_COUNT","PROP_DEST","INJURY","COLLISION_WITH_1","COLLISION_WITH_2")


#Step 3: Understand the data using SQL (via SQLDF)

colnames(MyData)

#How many accidents happened on Sunday 
MyData
Sunday <-sqldf("select sum(DAY_OF_WEEK) from MyData where DAY_OF_WEEK = 'MONDAY'")
Sunday


NumInjuries <- sqldf("select count(INJURY) from MyData where INJURY = 'YES'" )
NumInjuries

InjByDay <- sqldf("select count (INJURY), DAY_OF_WEEK from MyData Group by DAY_OF_WEEK")
InjByDay

#Step 4: UNderstand the data using tapply 

attach(MyData)
tapply(DAY_OF_WEEK, DAY_OF_WEEK = Sunday, sum) #average weight of cars with 8 cylinders vs not


tapply(DAY_OF_WEEK, INJURY, count)