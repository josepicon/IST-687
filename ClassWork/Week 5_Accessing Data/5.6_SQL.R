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
