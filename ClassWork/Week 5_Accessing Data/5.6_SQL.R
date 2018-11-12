#5.6 SQL 
install.packages(sqldf)
library("sqldf")

results <- sqldf('select mtcars.mpg from mtcars')
mean(results$mpg)

#mpg with cars that have 4 cyl
results <- sqldf('select mtcars.mpg from mtcars where cyl=4')
results$mpg

#the number of cars wwith 4 cyl
results <- sqldf('select count(mtcars.mpg) from mtcars where cyl=4')
results

#3 different groups of avg mpg by cyl using tapply
tapply(mtcars$mpg, mtcars$cyl, mean)

#avg mpg from mtcars 
sqldf('select AVG(mtcars.mpg) from mtcars')

#3 different groups of avg mpg by cyl using sqldf
sqldf('select AVG(mtcars.mpg) from mtcars group by mtcars.cyl')

#avg mpg for cars that have 4cyl vs not 4 cyl
tapply(mtcars$mpg, mtcars$cyl==4, mean)

sqldf('select AVG(mtcars, mpg) from mtcars where cyl=4')

#the tapply/R style 
tapply(mtcars$mpg, mtcars$cyl==4, mean)

#trditional database style 
sqldf('select AVG(mtcars.mpg) from mtcars where cyl=4')

results <-tapply(mtcars$mpg, mtcars$cyl==4, mean)
str(results)

newresults <- unlist(results)
str(newresults)

newresults

goodMPGcar <- function(mpg) {
  if(mpg > 24)
    return(TRUE)
  return(FALSE)
}

goodMPGcar(mtcars$mpg[20])

mtcars[8,]
mtcars[7,]

#function that goes the entire function within mtcars$mpg
sapply(mtcars$mpg, goodMPGcar)

#stores all good cars 
goodCars <- sapply(mtcars$mpg, goodMPGcar)
mtcars[goodCars,]

meanPlusSD <- function(v) {
  t <- mean(v) + sd(v)
  return(t)
}

tapply(mtcars$mpg, mtcars$cyl, meanPlusSD)
