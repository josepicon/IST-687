#Week3

x <- c(1,2,3,4,5,6,7,8)
sum(x)/length(x)

x <- function(a) {
  v <- sum(a)/length(a)
  return(v)
}
  
#Function to sum 2 value

#give your function a name
myFunc1 <- function(a,b) { #starts with curly brackets, define processes of functions within here
  c <- a+b #adds a variable with b variable
  return(c) #returns new number
  
} 
myFunc1(5,6)

myFunc1 <- function(a) {
  c <- sum(a)
  l <- length(a)
  d <- c/1
  return (d)
}

myFunc2 <- function(v,x,z) #x is min value, z is max value
  {
  s <- v[v>x]
  s <- s[s<z]
  return(s)
}

d <- c(20:30) #set the list of values for v
 myFunc2(d, 22, 27) #call the function and send 1 vetor and 2 values

myFunc2 <- function(v,MinVal, MaxVal){
  s <- v[v>MinVal]
  cat("This is the 1st s:", s, "\n")
  
  s <- s[s<MaxVal]
  cat("This is 2nd s:", s, "\n")
  
} 
myFunc2(d, 10, 29)

#find the car with max hp
myFunc3 <- function(x,b){
  index <- which.max(x)
  rnames <- rownames(b)
  car <-rnames[index]
  return(car)
}
myFunc3(mtcars$cyl, mtcars) #can change a with hp, mpg, etc.

#function for weight and hieght 
myFunc4 <- function()
  
#HW3 Framework 
  testFrame <- read.csv(url(#insert link here))
  str(testFrame)
  head(testFrame, 1)
  View(testFrame) #first top 8 rows that need to be cleaned up, columns 4-6 as well 
  
  testFrame <- testFrame[-1:-8] #removes rows 1-8
  rownames(testFrame) <- NULL #gives rows new names 
  testFrame <- testFrame[-52:-80]
  testFrame <- testFrame[,-6:-10]
  ##------rename rows and columns
  rownames(testFrame) <- NULL
  colnames(testFrame) [1] <- "Name"
  
  
  #Eliminate periods in state names 
  testFrame$Name <-gsub("\\. ","", testFrame$Name)
  
  #claen up population data (remove commas, should be applied to some columns)
  testFrame$X <- gsub("\\,","",testFrame$X)
  testFrame$X <- as.numeric(testFrame$X)
  