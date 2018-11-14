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

MyData <-MyData[,-1:-8]
colnames(MyData) <-c("CASE_NUMBER","BARRACK","ACC_DATE","ACC_TIME","ACC_TIME_CODE","DAY_OF_WEEK","ROAD","INTERSECT_ROAD","DIST_FROM_INTERSECT","DIST_DIRECTION","CITY_NAME","COUNTY_CODE","COUNTY_NAME","VEHICLE_COUNT","PROP_DEST","INJURY","COLLISION_WITH_1","COLLISION_WITH_2")

#Step 3: Understand the data using SQL (via SQLDF)

#prof version, * means everything 
step3result <- sqldf("select count(*), DAY_OF_WEEK from MyData Group By DAY_OF_WEEK")
step3result <- sqldf("select count (*) from MyData where INJURY='YES'")

#my version 

#How many accidents happened on Sunday 

#version1 
SunAcc <- sqldf("select count (INJURY), DAY_OF_WEEK from MyData Group by DAY_OF_WEEK")
SunAcc <- SunAcc[-1:-3,]
SunAcc <- SunAcc[-2:-4,]
SunAcc

#version2 
SundayAcc <- sqldf("select DAY_OF_WEEK, count(DAY_OF_WEEK) from MyData where DAY_OF_WEEK like'%SUNDAY%' group by DAY_OF_WEEK") 
SundayAcc


#How	many	accidents	had	injuries

NumInjuries <- sqldf("select count(INJURY) from MyData where INJURY = 'YES'" )
NumInjuries

InjByDay <- sqldf("select count (INJURY), DAY_OF_WEEK from MyData where INJURY = 'YES' Group by DAY_OF_WEEK")
InjByDay

#Step 4: Understand the data using tapply 

#prof version 
tapply(MyData$DAY_OF_WEEK, MyData$DAY_OF_WEEK=='SUNDAY', length)
tapply(MyData$INJURY, MyData$INJURY=='YES', length)
tapply(MyData$DAY_OF_WEEK, list(MyData$DAY_OF_WEEK, MyData$INJURY=='YES'), length)
  

#Myversion 

#How	many	accidents	happen	on	Sunday

#version1
  
x <- tapply(MyData$CASE_NUMBER, list(MyData$DAY_OF_WEEK, MyData$INJURY), length) 
x <- x[-1:-3,]
x<- x[-2:-4,]
x <-data.frame(x)
SundayAccidents <- sum(x)
SundayAccidents

#version2

tapply(MyData$DAY_OF_WEEK, trimws(MyData$DAY_OF_WEEK)=='SUNDAY', length)
#true result is Sunday's count

-----------------

#How	many	accidents	had	injuries (remove	NAs	from	the	data)
tapply(MyData$DAY_OF_WEEK, MyData$INJURY=='YES', length)
#True result is number of injuries 

#List	the	injuries	by	day
tapply(MyData$INJURY, list(MyData$DAY_OF_WEEK,MyData$INJURY=='YES'), length)

