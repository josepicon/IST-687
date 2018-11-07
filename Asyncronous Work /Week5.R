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

mycars <- mtcars
#attach so you dont have to call the df for each attribute 
attach(mycars)

mean(mpg)

tapply(mpg, cyl, mean) #cars of 4 cyl, will have avg, 6 cyl will have, etc

tapply(mpg, cyl, max) #the max mpg for each number of cyclinders 

tapply(wt, cyl==8, mean) #average weight of cars with 8 cylinders vs not 

tapply(mpg, list(hp, cyl), mean) #cols are number of cylinders, rows are hp, values are average mpg

tapply(mpg, list(hp >65, cyl), mean) #cols are cyl, rows are hp >65, values are average mpg

x <- tapply(cyl, list(mpg>mean(mpg)cyl), mean) #the value is higher than the mean 
x

#sql commands: 
#select - what columns 
#from - what dataset 
#where - filters e.g. cyl = 4
#add - adding 
#group by - grouper
#count - length in R 
#sum 
#avg 
#median 

#"select" and "from" are required
sqldf("select cyl from mycars where cyl > 2") #SQL version 
#same as: 
mycars$cyl #R version 

sqldf("select avg(mpg) from mycars group by cyl") #average mpg and group by cylinders 
#same as 
tapply(mpg, cyl, mean)

sqldf("select avg(mpg) from mycars group by cyl, vs") #multiple groupers 

sqldf("select avg(mpg), cyl, vs from mycars group by cyl, vs") #show column names 

sqldf("select sum(mpg), cyl, count(hp) from mycars where cyl > 4 group by cyl") #multiple calulations in one command 

#HW 5 -------------------------------------------------------------

#Step 3 

#install libraries if not installed yet 

link <- 'https://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD'

JSONInput <- fromJSON("https://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD")

JSONInput$data #(or can use 'meta' to see metadata)

JSONData <- JSONInput$data #make into a datafrom 

MyData <- data.frame(JSONData)


#Look into the dataset 
View(MyData)

nameofColumns <- c()

colnames(MyData) <- namesofcolumns 

#Step 3 of using sqldf 

FirstQuery <- sqldf("select sum(x13) from MyData where Day = 'Sunday'")
SecondQuery <- sqldf("select count(###) from ### where ###")
ThirdQuery <- sqldf("select count (###), day from ### Group by day")
  
#Step 4 do the same using tapply 
  
#use similar to tapply(mpg, cyl==8, length)
