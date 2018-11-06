#3.4 R: Writing Functions 

colnames(mtcars)
rnames <- row.names(mtcars)
rnames[20]

bestMPG <- function(){
  index <- which.max(mtcars$mpg)
  car <- mtcars[index,]
  return(car)
}

#testing the function 
bestMPG()

bestMPGName <- function(){
  index <- which.max(mtcars$mpg)
  rnames <- rownames(mtcars)
  car <- rnames[index]
  return(car)
}

bestMPGName()


col.index <- colnames(mtcars) =="mpg" 

bestWithIndex <- function(col.index){
  index <- which.max(mtcars[,col.index])
  rnames <- rownames(mtcars)
  car <- rnames[index]
  return(car)
}

bestWithIndex()

 

which.max(mtcars[,col.index])

best <- function(col.name){
  col.index <- which(colnames(mtcars)==col.name)
  index <- which.max(mtcars[,col.index])
  rnames <- rownames(mtcars)
  car <- rnames[index]
  return(car)
}
best ("mpg")

#what is happening in above funtion

which(colnames(mtcars)=="")
