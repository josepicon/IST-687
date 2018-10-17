#Week 2 

#define vectors 
age <- c(40, 50, 60)
wt <- c(100, 130, 150)

data.frame(age, wt) #displays the dataframe in the console, not stored anywhere
View(data.frame(age, wt))

#create a data frame table 
MyDF <- data.frame(age, wt, c(2, 3, 4))
View(MyDF)

MyDF #obervations a re rows and variables are columns; called arttibutes 

age <- age+3

age
MyDF #note that age in data frame didn't change because it was created before the change
age [2] #refers to the second value in age 

MyDF[1,2] #references elements in brackets, row number 1 and column number 2 
MyDF[2,2] #references elements in brackets, row number 2 and column number 2 

x <- MyDF [1,]
MyDF [,2] #references elements in brackets, column number 2 !!Will be on the quiz!!

MyDF [1,1] <- 5 #changes number in row 1, column 1 to "5"

MyNewDataFrame <- MyDF [,2]

MyDF$wt

mean(MyDF$age)

#use $ to reference one column 
mean(MyDF$age)
age

#create new column in MyDF 
MyDF$NewAge <- age + 5

#override above with new numbers 
MyDF$NewAge <-MyDF$NewAge +2 

#add the new age to the DF that I already have in a new attribute
MyDF$NewAge <- age
MyDF


MyDF$NewAge <- NULL 
MyDF

#add new column name 
colnames(MyDF) [3] <- "NewCol"
MyDF

#adding new rows in a data frame
MyDF <- rbind(MyDF, c(5,6, 35))
MyDF

#sort ascending to rows
MyDF[order(MyDF$`2`),]

#sort descending to rows
MyDF[order(-MyDF$`2`),]

#install a package in R and use a function on it to rename rows 
install.packages("data.table")
library(data.table)

?data.table

#function that will make changes to the data frame 
setattr(MyDF, "row.names", 1:4)

#function from this library to change the column names 
setnames(MyDF, 2, "wt")
names(MyDF) <- c("a", "b", "c")

#view the dataset
view(MyDF)

#shows data sets store in machine locally
data()

#seek info about the dataset 
?mtcars

#list the data
mtcars

#This is a data frame that has observations and variables, row values is not a variable 
#strucutre command to get an idea about the meta data (structure)

rownames(mtcars)

#first thing to do when looking at a dataframe is using str function that gives you a description of the data set 
str(mtcars)

# second thing to look at is summary function gives you a quick sum of the data set 
summary(mtcars)
summary(mtcars$mpg)

#allows you to play around with the data frame and still retreiving original 
MyCars <- mtcars

MyCars[1,]
MyCars [1,3]

MySortedCars <- MyCars[order(MyCars$mpg, -MyCars$cyl),]

#gives you the top 6 datasets
head(MySortedCars)
tail(MySortedCars)
tail(MySortedCars, 1)

#descending with the negative - high to low 

MeanMPG <- mean (MyCars$mpg)
MySortedCars$mpg>MeanMPG

MyCars[MyCars$mpg>=21 & MyCars$<=24,]

#what is the max value in my dataset
max(MyCars$mpg)
which.max(MyCars$mpg) #which position includes the maximum value, (row 20 has highest value)

#store value 
MaxMPG <- max(MyCars$mpg)
MaxIndex <-which.max(MyCars$mpg)
MyCars[MaxIndex,]

#show the minimum
MyCars[which.min(MyCars$mpg),]
