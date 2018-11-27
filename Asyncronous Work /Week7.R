#Week 7 

install.packages("ggplot2")
install.packages("openintro") #states data 
install.packages("ggmap")
install.packages("readxl") #used to read xl files 
install.packages("sqldf") 
install.packages("gdata") #to reformat some data sets, such as cbinx function
install.packages("zipcode")
library()
#Read the data 

setwd ("G:\\My Drive\\Applied Data science\\Fall 2019\\w7") #set working directory
df <- read_xlsx ("MediaZip_2_2.xlsx") #file name
head(df)
str(df)
View(df)

#Clean up the dataframe 

#remove uneeded information 
df <- df[-1,] #remove first row 
colnames(df) <- c("zip", "mean", "median", "population")

#remove commas and numeric 

df$median <- as.numeric(gsub(",", "", df$median))
df$mean <- as.numeric(gsub(",", "", df$mean))
df$population <- as.numeric(gsub(",", "", df$population))

#load the 'zipcode' package 

data(zipcode) #attach dataset to global environment (your local machine)

df$zip <- clean.zipcodes(df$zip) #reformat the zipcodes, makes sure all numbers (zipcodes) are in the data ie). 1001 > 01001

#4: Merge the zipcode information from two data frames 
dfNew <- merge(df, zipcode, by="zip") #adds more columns, zipcode is the same, matches both dataframes by "zip", merge can join in different ways 
head(dfNew)

#5. Remove Hawaii and Alaska 
df$New <- dfNew [dfNew$state != "HI",]
df$New <- dfNew [dfNew$state != "AK",]
df$New <- dfNew [dfNew$state != "DC",]

#Create a simpler dataframe with media income and population 
income <- tapply(dfNew$median, dfNew$state, mean) #average income, across different states 
state <- row.names(income) #grabs the row names of income 
medianIncome <- data.frame(state, income) #dataset that combines row names and average income 

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




