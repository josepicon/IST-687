install.packages("ggplot2")
library('ggplot2')

air <- airquality

any(is.na(air$Ozone))

length(air[str=='NA'])

colnames(air[col$ums(is.na(air))]>0)

air$Ozone[is.na(air$Ozone)] <- mean(air$Ozone, na.rm = TRUE) #replace NA's in Ozone col 
air$Solar.R[is.na(air$Solar.R)] <- mean(air$Solar.R, na.rm = TRUE) #replace NAs in SOlar. R cols 

---------
#compoenents of ggplot: the data set, the aesthetics (x, y axis, color) 

#or can create geom_line(), stat_smooth() shows range within the numbers 
p <- ggplot(data=air, aes(x=ozone, y=Temp, color=Month)) + geom_point() + stat_smooth()

p + geom_xxx() + Stat_xxx()

#you can use subset of your data by using the following: 
p <- ggplot(data=subset(airquality, Month>6), aes(x=Ozone, y=Temp, color=Month)
            --------
#Generate charts, histograms, boxplot, line plot, point plot and tile
            #DATASET      #AESTHETICS           #TYPE OF CHART (each type of chart has different aes and details)
MyGraph <- ggplot(air, aes(x=Ozone, y=Ozone)) + geom_histogram(binwidth = 10, color="white", fill="blue") 

#adjust to be in a position in center(.5 is in the center) with hjust, change x title with xlab 

My Graph <- MyGraph + ggtitle("Test") + theme(plot.title = element_text(hjust = 0.5)) + xlab("OZ")


#the next is to create a boxplot 
gbox.ozone <- ggplot(air, aes((0), Ozone)) + geom_boxplot()
gbox.ozone

#explore how the data changes over time 
#paste value in Month Day columns and 1973 and assign to column "Date" 
air$Date <- paste("1973", air$Month, air$Day, sep = "-")
air$Date <- as.Date(air$Date, "%Y-%m-%d")

str(air)
air <- air[,-5:-6]
str(air)

#create line charts for ozone, temp, wind and solar.r 
#line chart for ozone, base size is size of legends 
gline.ozone <- ggplot(data = air, aes(x=Date, y=Ozone)) + geom_line() + theme_classic(base_size = 10)
gline.ozone + geom_line()


#create one chart with 4 lines 
#use melt function to transform data frame 
library(reshape2)
#melt: "keep the data as it is, Date is the id and each row shoes the value of Ozone, Solar, etc, for each date 
airLong <- melt(air, id="Date")
head(airLong[order(airLong$Date),])

#create chart with all 4 variables 
gline.all <- ggplot(airLong, aes(x=Date, y=value, color=variable)) + geom_line()
gline.all #inspect chart

#Step 4: Look at all the data via the Heatmap 
#scalefill gradient changes the colors 
htmap <- ggplot(airLong, aes(x=Date, y=variable)) + geom_tile(aes(fill=value)) + scale_fill_gradient(low="white",high = "blue"))
htmap

gscatter <- ggplot(air, aes(x=Wind, y=Temp)) + geom_point

#add colors and add more information to the chart 
gscatter <- ggplot(air, aes(x=Wind, y=Temp)) + geom_point(aes(size=Ozone, color=Solar.R))
gscatter
