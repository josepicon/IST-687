#5.5 R & SQL 

#SDQLDF R Package 

sqldf('select AVG(mtcars.mpg) from mt cars where cylc=4')

#sapply(Variable, function, optional parameters)

#get the mean for each column in mtcars 
sapply(mtcars, mean)

#tapply (Summary variable, group variable, function)

#get the mean MPG for each cyl 
tapply(mtcars$mpg, mtcars$cyl, mean)

#use own function (not mean)

meanPlusSD <- function(v){
  t <- mean(v) + sd(v)
  return(t)
}
tapply(mtcars$mpg, mtcars$cyl, meanPlusSD)