#5.4 Importing Spreadsheets 

#R packages 
install.packages("gdata")
library("gdata")

testFrame <- read_xls("https://www.census.gov/popset/data/state/totals/2011/tables/NST-EST2011-01.xls")

#view the results of read.xls
view(testFrame)

#strucutre of testFrame, provide summary statstics about the data frame testFrame
str(testFrame)

#Cleansing 
#rermove header rows 
#remove uneeded columns 
#remove last few rows 
#copy first column with a good name 

#Transform 
#remove the dots on front of state names 

#remove 1st 3 rows,,, column parameter empty 
testFrame <- testFrame[-1:-3,]

#keep the 1st 5 columns,,, row parameter empty 
testFrame <- testFrame[,1:5]

#Look at the last 5 rows of testFrame
tail(testFrame,5)

#remove last 5 rows 
testFrame <- testFrame[-58:-62,]

#view testFrame post cleansing 
testFrame

#Numberize() - Gets rid of commas and oher junk and converts to numbers 
#Assumes that the inputVector is a list of data that can be treated as charatcter strings 

Numberize <- function(inputVector){
  inputVector<-str_replace_all(inputVector,",","") #remove commas 
  inputVector<-str_replace_all(inputVector,"","") #remove spaces
  return(as.numeric(inputVector))
}

#apply Numberize funtion to columns in testFRame and five columns a new name 

testFrame$april10census <- Numberize(testFrame$X)
testFrame$april10base <- Numberize(testFrame$X.1)
#etc.,

