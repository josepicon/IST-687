#Week6: Visualization: Air Quality Analysis 

#Step 1: Load the Data 
air <- airquality

#Step 2: Clean the Data 

air$Ozone[is.na(air$Ozone)] <- mean(air$Ozone, na.rm = TRUE) #replace NA's in Ozone col 
air$Solar.R[is.na(air$Solar.R)] <- mean(air$Solar.R, na.rm = TRUE) #replace NAs in SOlar. R cols 


#Step 3: Understand the data distribution 
#Create the following visualizations using ggplot: 
install.packages("ggplot2")
library('ggplot2')

#Histograms for each of the variables: 
OGraph <- ggplot(air, aes(x=Ozone)) + geom_histogram(binwidth = 10, color="white", fill="blue") 
OGraph

SGraph <- ggplot(air, aes(x=Solar.R)) + geom_histogram(binwidth = 20, color="white", fill="red") 
SGraph

WGraph <- ggplot(air, aes(x=Wind)) + geom_histogram(binwidth = 1, color="white", fill="green") 
WGraph

TGraph <- ggplot(air, aes(x=Temp)) + geom_histogram(binwidth = 5, color="white", fill="yellow") 
TGraph

#Boxplaots for Ozone: 
gbox.ozone <- ggplot(air, aes((0), Ozone)) + geom_boxplot()
gbox.ozone

#Boxplot for wind values (round the wind to get a good number of "buckets")
windVal <- data.frame(round(air$Wind, digits = 0))
colnames(windVal)[1] <-  "Wind"
gbox.wind <- ggplot(windVal, aes((0), Wind)) + geom_boxplot()
gbox.wind

#Step 3: Explore how the data changes over time
#make	sure	to	create	appropriate	dates	

air$Date <- paste("1973", air$Month, air$Day, sep = "-")
air$Date <- as.Date(air$Date, "%Y-%m-%d")
air <- air[,-5:-6]


#create	linecharts for	ozone,	temp,	wind	and	solar.R (one	line	chart	for	each)

gline.ozone <- ggplot(data = air, aes(x=Date, y=Ozone)) + geom_line() + theme_classic(base_size = 10)
gline.ozone + geom_line()

gline.temp <- ggplot(data = air, aes(x=Date, y=Temp)) + geom_line() + theme_classic(base_size = 10)
gline.temp + geom_line()

gline.wind <- ggplot(data = air, aes(x=Date, y=Wind)) + geom_line() + theme_classic(base_size = 10)
gline.wind + geom_line()

gline.SR <- ggplot(data = air, aes(x=Date, y=Solar.R)) + geom_line() + theme_classic(base_size = 10)
gline.SR + geom_line()


#then	one	chart	with	4	lines,	each	having	a	different	color

library(reshape2)
airLong <- melt(air, id="Date")
head(airLong[order(airLong$Date),])

gline.all <- ggplot(airLong, aes(x=Date, y=value, color=variable)) + geom_line()


#Step 4: Look at all the data via a Heatmap 

#scalefill gradient changes the colors 
#Create a	heatmap,	with	each	day	along	the	x-axis	and	ozone,	temp,	wind	and	solar.r	along	the	y-axis,	and	days	as	rows	along	the	y-axis.	
htmap <- ggplot(airLong, aes(x=Date, y=variable)) + geom_tile(aes(fill=value)) + scale_fill_gradient(low="white", high = "blue")



#Create	a	scatter	chart (using	ggplot	geom_point),	with	the	x-axis	representing	the	wind,	the	y-axis	representing	the	temperature,	the	size	of	each	dot	representing	the	ozone	and	the	color	representing	the	solar.R

gscatter <- ggplot(air, aes(x=Wind, y=Temp)) + geom_point(aes(size=Ozone, color=Solar.R))
gscatter

#Step 6: Final Analysis 

#Patterns:
#1: based on the visualization in the scater plot, the days within 90 to 70 degrees have the highest levels of Solar radiation. 
#2: based on the heatmap, the month with the most days of high solar.r are in June and the lowest are September 
#3: the line chart shows that wind levels are highest in Sept on average 

#Most useful: 

#I think the most useful chart is the line chart because it visualizes all the variables and orders them in chronogolical order

