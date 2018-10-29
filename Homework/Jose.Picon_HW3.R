#Cleaning/munging dataframes 

#Step 1: Create a function (named readStates) to read a CSV file into R 

#1: Note that you are to read a URL, not a file local to your computer

readStates <- read.csv(url("http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"))

#Step 2: Clean the dataset 

readStates

#remove rows, make sure there are 51 rows 
readStates <- readStates[-c(1:8, 60:66),]

#remove columns, make sure there are only 5 columns 
readStates <- readStates[-c(6, 7, 8, 9, 10)]

readStates
#rename columns 
colnames(readStates) [1] <- "stateName"
colnames(readStates) [2] <- "base2010"
colnames(readStates) [3] <- "base2011"
colnames(readStates) [4] <- "Jul2010"
colnames(readStates) [5] <- "Jul2011"

readStates

#claen up population data (remove commas)
readStates$base2010 <- gsub("\\,","",readStates$base2010)
readStates$base2010 <- as.numeric(readStates$base2010)

readStates$base2011 <- gsub("\\,","",readStates$base2011)
readStates$base2011 <- as.numeric(readStates$base2011)

readStates$Jul2010 <- gsub("\\,","",readStates$Jul2010)
readStates$Jul2010 <- as.numeric(readStates$Jul2010)

readStates$Jul2011 <- gsub("\\,","",readStates$Jul2011)
readStates$Jul2011 <- as.numeric(readStates$Jul2011)

readStates

#Eliminate periods in state names 
readStates$stateName <-gsub("\\. ","", readStates$stateName)



readStates

readStates
#Step 3: Store and explore the dataset

#store the dataset into a data frame, called dfStates
dfStates <- data.frame(readStates)
dfStates

mean(dfStates$Jul2011) 

#Step4: Find the state with the Highest Population 

#Based	on	the	July2011	data,	what	is	the	population	of	the	state	with	the	highest	population?	What	is	the	name	of	that	state?

#option1
myFunc3 <- function(x,b){
  index <- which.max(x)
  rnames <- rownames(b)
  state <-rnames[index]
  return(state)
}
myFunc3(dfStates$Jul2011, dfStates)

#Sort	the	data,	in	increasing	order,	based	on	the	July2011	data.	
dfStates[order(dfStates$Jul2011),]

#Step 5: Expore the distribution of the states

#Write	a	function	that	takes	two	parameters.	The	first	is	a	vector	and	the	second	is a	number.

#The	function	will	return	the	percentage	of	the	elements	within	the	vector	that	is	less than	the	same	(i.e.	the	cumulative	distribution	below	the	value	provided).

#For	example,	if	the	vector	had	5	elements	(1,2,3,4,5),	with	2	being	the	number passed	into	the	function,	the	function	would	return	0.2	(since	20%	of	the	numbers	were	below	2).
index1 <- mean(dfStates$Jul2011)
d <- dfStates$Jul2011 #set the list of values for v

myFunc2 <- function(v,z) #x is min value, z is max value
{
  h <- v[v>z] #numbers inside the vector greater than the value
  e <- length(h) #length of vector with numbers greater than value
  l <- length(v) #length of vector d <- (dfStates$Jul2011)
  p <- e/l
 
  return(p)
}


myFunc2(d, index1) #call the function and send 1 vetor and 1 value

#option 2, max value, Jul2011 vector 
index2 <- max(dfStates$Jul2011)
k <- dfStates$Jul2011

myFunc2(k, index2)

#option3, median value, Jul2011 vector 
index3 <- median(dfStates$Jul2011)
n <- dfStates$Jul2011

myFunc2(n, index3)
