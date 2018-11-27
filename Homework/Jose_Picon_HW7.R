#Week 7 

install.packages("ggplot2")
install.packages("openintro") #states data 
install.packages("ggmap")
install.packages("readxl") #used to read xl files 
install.packages("sqldf") 
install.packages("gdata") #to reformat some data sets, such as cbinx function
install.packages("zipcode")
library("ggplot2")
library("openintro")
library("ggmap")
library("readxl")
library("sqldf")
library("gdata")
library("zipcode")

#Step1: Load the Data


#Read the data 

setwd("/Users/josepicon/Desktop/Projects /IST 687")
df <- read_xlsx ("MedianZip_2_2_2_2.xlsx") #file name
head(df)
str(df)
View(df)

#Clean up the dataframe 
df <- df[-1,] #remove first row 
colnames(df) <- c("zip", "mean", "median", "population")

#remove commas and numeric 

df$median <- as.numeric(gsub(",", "", df$median))
df$mean <- as.numeric(gsub(",", "", df$mean))
df$population <- as.numeric(gsub(",", "", df$population))

#3 load the 'zipcode' package 

data(zipcode) 
df$zip <- clean.zipcodes(df$zip) 

#4: Merge the zipcode information from two data frames 
dfNew <- merge(df, zipcode, by="zip") #adds more columns, zipcode is the same, matches both dataframes by "zip", merge can join in different ways 

#5. Remove Hawaii and Alaska 
dfNew <- dfNew [dfNew$state != "HI",]
dfNew <- dfNew [dfNew$state != "AK",]
dfNew <- dfNew [dfNew$state != "DC",]


#Step 2


#1 Create a simpler dataframe with average median income and population for each state

#median income, states, function
income <- tapply(dfNew$median, dfNew$state, mean) 

#2 add the state abbreviationsand he state names as new columns 
state <- row.names(income) 

#3 Show the US map, representing the color with the average median income of that state 
medianIncome <- data.frame(state, income) #dataset that combines row names and average income 
medianIncome$state <- tolower(medianIncome$state)
medianIncome

MapIncome <- ggplot(medianIncome, aes(map_id=state))


MapIncome <- MapIncome + geom_map(map=us, aes(fill=medianIncome$income)) 
MapIncome <- MapIncome + expand_limits(x=us$long, y=us$lat) #adds US map into the heatmap, long/lat came from map_data
MapIncome

#-----------------------------------
pop <- tapply(dfNew$population, dfNew$state, sum) #how many people do we have across differrent states 
state <- row.names(pop)
statePop <- data.frame(state, pop)

dfSimple <- merge(medianIncome, statePop, by="state")
head(dfSimple) #output: state names, income, population

#previous steps can be done using sql and scaling the income at the state level 
dfSimple <- sqldf("select state, avg(median) as income, sum(population) as pop from dfNew group by state")
dfSimple <- sqldf("select state, (income/popmedian) as income, pop from dfSimple")

#add state abbrev and state names (lower case)
#use match

dfSimple$stateName <- state.name[match(dfSimple$state, state.abb)]

#to lwowercase
dfSimple$stateName <- tolower(dfSimple$stateName)

#show US map, representing color with average media icome 
us <- map_data("state")

MapIncome <- ggplot2(dfSimple, aes(map_id=stateName))
MapIncome <- MapIncome + geom_map(map=us, aes(fill=dfSimple$income)) #fills heatmap with income values
MapIncome <- MapIncome + expand_limits(x=us$long, y=us$lat) #adds US map into the heatmap, long/lat came from map_data

MapIncome <- MapIncome + coord_map() #better looking 
MapIncome <- MapIncome + ggtitle("avg media income by state")


#funciton to remove axis formats 

ditch_thea_axes <- theme{
  
}
#cont.... 

#Draw each zipcode on map where color of dot is based on median income 
dfNew$stateName <- state.name[match(dfNew$state, state.abb)]
dfNew$stateName <- tolower(dfNew$stateName)

MapZip <- ggplot(dfNew, aes(map_id=stateName))
MapZip <- MapZip + geom_map(map=us, fill="black", color="white")

MapZip <- MapZip + expand_liimts(x=us$long, y=us$lat)

MapZip <- MapZip + geom_point(data=dfNew, aes(x=dfNew$longitude, y=dfNew$latitude, color=dfNew$median))


#cont.... 


#generate a map showing density of zipcode

MapZip <- ggplot(dfNew, aes(map_id=stateName))
MapZip <- MapZip + geom_map(map=us, fill="black", color="white")

MapZip <- MapZip + expand_liimts(x=us$long, y=us$lat)

#adding density lines instead of points 
MapZip <- MapZip + stat_density_2d(data=dfNew, aes(x=dfNew$longitude, y=dfNew$latitude, color=dfNew$median))

MapDensity <- MapDensity + coord_map
#cont... 
#########

#try this and see if it works 
zoomGeo <- geocode("Harvard University, MA") #calling Google from R in ggmap
zoomAmount <- 5 

centerx <- zoomGeo$lon
centery <- zoomGeo$lat

ylimit <- c(centery-zoomAmount, centery+zoomAmount)
ylimit <- c(centerx-zoomAmount, centerx+zoomAmount)

#show income per zipcode around NYC 
MapZipZoom <- MapZip + xlim(xlimit) + ylim(ylimit) + coord_map 

#cont.... 




