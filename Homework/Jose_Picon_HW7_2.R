install.packages("ggplot2")
install.packages("openintro") #states data 
install.packages("ggmap")
install.packages("readxl") #used to read xl files 
install.packages("sqldf") 
install.packages("gdata") #to reformat some data sets, such as cbinx function
install.packages("zipcode")
install.packages("googleway")
library("ggplot2")
library("openintro")
library("ggmap")
library("readxl")
library("sqldf")
library("gdata")
library("zipcode")
library("googleway")

#Step1: Load the Data

?ggmap
#Read the data 

setwd("/Users/josepicon/Desktop/Projects /IST 687")
df <- read_xlsx ("MedianZip_2_2_2_2.xlsx") #file name
head(df)
str(df)


#Clean up the dataframe 
df <- df[-1,] #remove first row 
colnames(df) <- c("zip", "mean", "median", "population")


df$median <- as.numeric(gsub(",", "", df$median))
df$mean <- as.numeric(df$mean)
df$population <- as.numeric(df$population)
df$median <- na.omit(df$median)

#3 load the 'zipcode' package 

data(zipcode) 
df$zip <- clean.zipcodes(df$zip) 

#4: Merge the zipcode information from two data frames 
dfNew <- merge(df, zipcode, by="zip") #adds more columns, zipcode is the same, matches both dataframes by "zip", merge can join in different ways 

#5. Remove Hawaii and Alaska 
dfNew <- dfNew [dfNew$state != "HI",]
dfNew <- dfNew [dfNew$state != "AK",]
dfNew <- dfNew [dfNew$state != "DC",]
dfNew <- dfNew [dfNew$median != "NA",]


#Step 2

#1 Create a simpler dataframe with average median income and population for each state

income <- tapply(dfNew$median, dfNew$state, mean) 



state <- row.names(income) 
medianIncome <- data.frame(state, income) #dataset that combines row names and average income 
pop <- tapply(dfNew$population, dfNew$state, sum) #how many people do we have across differrent states 
state <- row.names(pop)
statePop <- data.frame(state, pop)
dfSimple <- merge(medianIncome, statePop, by="state")


#2 add the state abbreviationsand he state names as new columns 

dfSimple$stateName <- state.name[match(dfSimple$state, state.abb)]
#to lwowercase
dfSimple$stateName <- tolower(dfSimple$stateName)

#3: Show the US map, representing the color with the average median income of that state 

us <- map_data("state")

MapIncome <- ggplot(dfSimple, aes(map_id=stateName))
MapIncome <- MapIncome + geom_map(map=us, aes(fill=dfSimple$income)) #fills heatmap with income values
MapIncome <- MapIncome + expand_limits(x=us$long, y=us$lat) #adds US map into the heatmap, long/lat came from map_data

MapIncome <- MapIncome + coord_map() #better looking 
MapIncome <- MapIncome + ggtitle("avg median income by state")
MapIncome

#4: Create	a	second	map	with	color	representing the	population	of	the	state

MapPop <- ggplot(dfSimple, aes(map_id=stateName))
MapPop <- MapPop + geom_map(map=us, aes(fill=dfSimple$pop))
MapPop <- MapPop + expand_limits(x=us$long, y=us$lat)

MapPop <- MapPop + coord_map() #better looking 
MapPop <- MapPop + ggtitle("population by state")
MapPop

#Step 3: Show the income per zip code

MapZip <- ggplot(dfSimple, aes(map_id=stateName))
MapZip <- MapZip + geom_map(map=us, aes(fill="black", color="red"))

MapZip <- MapZip + expand_limits(x=us$long, y=us$lat)

MapZip <- MapZip + geom_point(data=dfNew, aes(x=dfNew$longitude, y=dfNew$latitude, color=dfNew$median))


#Step 4: generate a map showing density of zipcode

MapDensity <- ggplot(dfSimple, aes(map_id=stateName))
MapDensity <- MapDensity + geom_map(map=us, fill="black", color="red")

MapDensity <- MapDensity + expand_limits(x=us$long, y=us$lat)

MapDensity <- MapDensity + stat_density_2d(data=dfNew, aes(x=dfNew$longitude, y=dfNew$latitude, color=dfNew$median))

MapDensity <- MapDensity + coord_map()



#Step 5: Zoom in to the region around NYC 

#1: Repeat	steps	3	&	4,	but	have	the	image	/	map	be	of	the	northeast	U.S.	(centered	around	New	York).

API_KEY <- "AIzaSyAX4zk2kHEUb0JTyNKvvvYrXzvSyWYQ8io"
zoomGeo <- google_geocode("new york", key = API_KEY) #calling Google from R in ggmap
zoomAmount <- 5 


centerx <- zoomGeo$lon
centery <- zoomGeo$lat

ylimit <- c(centery-zoomAmount, centery+zoomAmount)
ylimit <- c(centerx-zoomAmount, centerx+zoomAmount)

MapZipZoom <- MapZip + xlim(xlimit) + ylim(ylimit) + coord_map 





nymap <- sqldf("select long, lat, region from us where region = 'new york'")

dfNewYork <- sqldf("select zip, city, avg(median) as income, sum(population) as pop, longitude as long, latitude as lat from dfNew where state = 'NY' group by city")

NYZip <- ggplot(dfNewYork, aes(map_id=state))
NYZip <- NYZip + geom_map(map=nymap, fill="black", color="white")

?geom_map
NYZip <- NYZip + geom_point(data=dfNewYork, aes(x=nymap$long, y=nymap$lat, color=dfNewYork$income))
NYZip
