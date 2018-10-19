myCars <- mtcars

#Step 1: What is the hp (hp stands for "horse power)

#1 what is the highest hp? 
max(myCars$hp)
which.max(myCars$hp)

#Step 2: Explore mpg

#1 what is the highest mpg? 
max(myCars$mpg)

#2 Which car has the highest mpg
which.max(myCars$mpg)

#Create a sorted dataframe, based on mpg
mySortedCars <- myCars[order(myCars$mpg),]

#Step 3: Which car has the "best" combination of mpg and hp? 

#6 What logic did you use / Which Car? 

myCars
bestcar <- myCars$mpg + myCars$hp
which.max(bestcar)
#Masserati Bora 

#Step 4: 