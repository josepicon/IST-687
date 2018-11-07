#Samples 

#Step 1: Write a summarizing function to understand the distribution of a vector 
#1. The function, call it 'printVecInfo' should take a vector as an input 

#2. The	function	should	print	the	following	information: a. Mean, b. Median, c. Min	&	max, d. Standard	deviation, e. Quantiles	(at	0.05	and	0.95), f. Skewness

printVecInfo <- function(x)
  {
  a <-mean(x)
  b <-median(x)
  z <-max(x)
  u <-min(x)
  p <-sd(x)
  d <- quantile(x, 0.05) 
  w <- quantile(x, 0.95)
  k <- skewness(x)
  cat("mean:", a, "\nmedian:", b, "\nmax:", z, "\nmin:", u, "\nsd:", p, "\nquantile:", d, "\nquantile:", w, "\nskewness:", k)
}

v <- c(1,2,2,3,3,3,4,4,4,4,5,5,5,6,6,7,10)
printVecInfo(v)

#Note	for	skewness,	you	can	use	the	function	in	the	‘moments’	library.
install.packages("moments")
library(moments)
skewness(v)

#3: Test	the	function	with	a	vector	that	has	(1,2,3,4,5,6,7,8,9,10,50).

x <- c(1,2,3,4,5,6,7,8,9,10,50)
printVecInfo(x)

#Step2: Creating Samples in a Jar 

#Create	a	variable	‘jar’	that	has	50	red	and	50	blue	marbles

A <- "Red"
B <- "Blue"

RepA <- replicate(50,A)
RepB <- replicate(50,B)

#store results in one bucket 
jar <- c(RepA, RepB)

#5: Confirm	there	are	50	reds	by	summing	the	samples	that	are	red
length(jar[jar=="Red"]) 

#6: Sample	10	‘marbles’	from	the	jar.	How	many	are	red?	What	was	the	percentage	of	red	marbles?
sampjar <- sample(jar, 10, replace = TRUE) 

RedCount <- length(sampjar[sampjar=="Red"]) #number of reds
RedCount  #number of reds in sample
RedPerc <- RedCount / length(sampjar) * 100
RedPerc #percent of reds in sample


#7: Do	the	sampling	20	times,	using	the	‘replicate’	command.	This	should	generate	a	list	of	20	numbers.	Each	number	is	the	mean	of	how	many	reds	there	were	in	10 samples.	Use	your	printVecInfo to	see	information	of	the	samples. Also	generate	a	histogram	of	the	samples.
f <- replicate(20, sam(jar, 10))
printVecInfo(f)
hist(f)

#8: Repeat	#7,	but	this	time,	sample	the	jar	100	times.	You	should	get	20 numbers,	this time	each	number	represents	the	mean	of	how	many	reds	there	were	in	the	100 samples.	Use	your	printVecInfo	to	see	information	of	the	samples.	Also	generate	a	histogram	of	the	samples
g <- replicate(20, sam(jar, 100))
printVecInfo(g)
hist(g)

#9: Repeat	#8,	but	this	time,	replicate	the	sampling	100 times.	You	should	get	100	numbers,	this	time	each	number	represents	the	mean	of	how	many	reds	there	were	in	the	100	samples.	Use	your	printVecInfo	to	see	information	of	the	samples.	Also	generate	a	histogram	of	the	samples.

m <- replicate(100, sam(jar, 100))
printVecInfo(m)
hist(m)

#Step 3: Explore the airquality dataset 

#10: Store the 'airquality' dataset into a temporary variable


air <- datasets::airquality

#11. Clean the dataset i.e) remove the NAs 

length(airair[airair=='NA']) #give you number of 'NA'
airair <- na.omit(air)

str(airair) #should not see any NAs 

rownames(airair) <-- NULL


#12. . Explore	Ozone,	Wind	and	Temp	by	doing	a	‘printVecInfo’	on	each	as	well	as generating	a	histogram	for	each

printVecInfo(airair$Ozone)
printVecInfo(airair$Wind)
printVecInfo(airair$Temp)

air$Ozone[is.na(air$Ozone)] <- mean(air$Ozone, na.rm = TRUE)
air$Solar.R[is.na(air$Solar.R)] <- mean(air$Solar.R, na.rm = TRUE)
#replacing NAs with the average value

str(air) #look at the strucutre to make sure all values are numeric 
air$Solar.R <- as.numeric(air$Solar.R)
str(air)
