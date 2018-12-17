#HW 9 - Support Vector Machines 
install.packages("kernlab")   
library("kernlab")
library(e1071)
library(ggplot2)
library(gridExtra)

#specify the packages of interest
packages=c("arulesViz", "kernlab","e1071","gridExtra","ggplot2", "caret", "arules")

#use this function to check if each package is on the local machine
#if a package is installed, it will be loaded
#if any are not, the missing package(s) will be installed and loaded
package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
})

#verify they are loaded
search()


#Step 1: Load the data 
air <- data.frame(airquality) 
colnames(air)[colSums(is.na(air)) > 0] # find which columns in the dataframe contain NAs.

# find the NAs in column "Ozone" + "Solar.R" and replace them by the mean value of this column
air$Ozone[is.na(air$Ozone)] <- mean(air$Ozone, na.rm=TRUE) 
air$Solar.R[is.na(air$Solar.R)] <- mean(air$Solar.R, na.rm=TRUE)

#Step 2: Create train and test data sets 

dim(air)
air[1:5,]
randIndex <- sample(1:dim(air)[1])
length(randIndex)

# In order to split data, create a 2/3 cutpoint and round the number
cutpoint2_3 <- floor(2*dim(air)[1]/3)

#check the 2/3 cutpoint
cutpoint2_3

#create train data set, which contains the first 2/3 of overall data
trainData <- air[randIndex[1:cutpoint2_3],]
dim(trainData)


# create test data, which contains the left 1/3 of the overall data
testData <- air[randIndex[(cutpoint2_3+1):dim(air)[1]],]

#check test data set
dim(testData)  

#Step 3: Build	a	Model	using	KSVM	&	visualize	the	results

# set "Ozone" as the target predicting variable; "." means use all other variables to predict "Ozone"
svmOutput <- ksvm(Ozone~., 
                  data = trainData, 
                  kernel = "rbfdot", 
                  kpar = "automatic",
                  C = 10, 
                  cross = 10, 
                  prob.model = TRUE 
)
# check the model
svmOutput

#2) Test the model with the testData data set
svmPred <- predict(svmOutput, 
                   testData, 
                   type = "votes"
)

compTable <- data.frame(testData[,1], svmPred[,1])
# change the column names to "test" and "Pred"
colnames(compTable) <- c("test","Pred")

# compute the Root Mean Squared Error
sqrt(mean((compTable$test-compTable$Pred)^2)) #A smaller value indicates better model performance.

# 3) Plot the results

compTable$error <- abs(compTable$test - compTable$Pred)

svmPlot <- data.frame(compTable$error, testData$Temp, testData$Wind, testData$Ozone)

# assign column names
colnames(svmPlot) <- c("error","Temp","Wind", "Ozone")

#plot result using ggplot, setting "Temp" as x-axis and "Wind" as y-axis
plot.ksvm <- ggplot(svmPlot, aes(x=Temp,y=Wind)) + 
  geom_point(aes(size=error, color=error))+
  ggtitle("ksvm")

plot.ksvm

# Step 4: Create a "goodOzone" variable

# calculate average Ozone
meanOzone <- mean(air$Ozone,na.rm=TRUE)

#create a new variable named "goodOzone" in train data set
#goodOzone = 0 if Ozone is below average Ozone
#googOzone = 1 if Ozone is eaqual or above the average ozone
trainData$goodOzone <- ifelse(trainData$Ozone<meanOzone, 0, 1)

# do the same thing for test dataset
testData$goodOzone <- ifelse(testData$Ozone<meanOzone, 0, 1)

# remove "Ozone" from train data
trainData <- trainData[,-1]

# remove "Ozone" from test data
testData <- testData[,-1]

# Step 5: See if we can do a better job predicting 'good' and 'bad' days

# convert "goodOzone" in train data from numeric to factor
trainData$goodOzone <- as.factor(trainData$goodOzone)

# convert "goodOzone" in test data from numeric to factor
testData$goodOzone <- as.factor(testData$goodOzone)

# 1)	Build a model 
#ksvm model
svmGood <- ksvm(goodOzone~.,
                data=trainData, 
                kernel="rbfdot", 
                kpar="automatic",
                C=5, 
                cross=10, 
                prob.model=TRUE 
)

svmGood


# 2) Test the model on the testing dataset, and compute the percent of 'goodOzone' that was predicted correctly, create a dataframe that contains the exact "goodOzone" value and the predicted "goodOzone"

goodPred <- predict(svmGood, 
                    testData
)

compGood1 <- data.frame(testData[,6], goodPred)
colnames(compGood1) <- c("test","Pred")
perc_ksvm <- length(which(compGood1$test==compGood1$Pred))/dim(compGood1)[1]
perc_ksvm

#3). Plot the results, Use a scatter plot. 

# determine the prediction is "correct" or "wrong" for each case
compGood1$correct <- ifelse(compGood1$test==compGood1$Pred,"correct","wrong")
Plot_ksvm <- data.frame(compGood1$correct,testData$Temp,testData$Wind,testData$goodOzone,compGood1$Pred)
colnames(Plot_ksvm) <- c("correct","Temp","Wind","goodOzone","Predict")
plot.ksvm.good <- ggplot(Plot_ksvm, aes(x=Temp,y=Wind)) + 
  geom_point(aes(size=correct,color=goodOzone,shape = Predict))+
  ggtitle("ksvm - good/bad ozone")
plot.ksvm.good
ksvmcorrect <- length(which(compGood1$correct=="correct"))
ksvmcorrect

#4:Compute	models and	plot	the	results	for	‘svm’ and	‘nb’

#SVM Model 
svmGood2 <- svm(goodOzone~.,data=trainData,kernel="radial",C=5,cross=10,prob.model=TRUE)
svmGood2

#test the svm model
goodPred2 <- predict(svmGood2,testData)
compGood2 <- data.frame(testData[,6],goodPred2)
colnames(compGood2) <- c("test","Pred")
perc_svm <- length(which(compGood2$test==compGood2$Pred))/dim(compGood2)[1]
perc_svm

#plot results of svm model
compGood2$correct <- ifelse(compGood2$test==compGood2$Pred,"correct","wrong")
plot.svm <- data.frame(compGood2$correct,testData$Temp,testData$Wind,testData$goodOzone,compGood2$Pred)
colnames(plot.svm) <- c("correct","Temp","Wind","goodOzone","Predict")
plot.svm.good <- ggplot(plot.svm,aes(x=Temp,y=Wind)) + geom_point(aes(size=correct,color=goodOzone,shape=Predict)) + ggtitle("svm - good/bad ozone")
plot.svm.good
svmcorrect <- length(which(compGood2$correct=="correct"))
svmcorrect


#NB Model 
m <- naiveBayes(goodOzone~.,
                data = trainData
)
m

mpred <- predict(m, testData)
mpred
compGoodnb <- data.frame(testData[,6], mpred)
colnames(compGoodnb) <- c("test","Pred")
perc_nb <- length(which(compGoodnb$test==compGoodnb$Pred))/dim(compGoodnb)[1]
perc_nb

compGoodnb$correct <- ifelse(compGoodnb$test==compGoodnb$Pred,"correct","wrong")
Plot_nb <- data.frame(compGoodnb$correct,testData$Temp,testData$Wind,testData$goodOzone,compGoodnb$Pred)
colnames(Plot_nb) <- c("correct","Temp","Wind","goodOzone","Predict")
plot.nb.good <- ggplot(Plot_nb, aes(x=Temp,y=Wind)) + 
  geom_point(aes(size=correct,color=goodOzone,shape = Predict))+
  ggtitle("nb - good/bad ozone")
plot.nb.good
nbcorrect <- length(which(compGoodnb$correct=="correct"))
nbcorrect

#5. Show all three results in one window using gridArrange function
grid.arrange(plot.ksvm.good,plot.svm.good, plot.nb.good, ncol=2, nrow=2, top="kvsm, svm, nb comparison")

table(compGood1)
table(compGood2)
table(compGoodnb)

#6:	Which	are	the	best	Models	for	this	data: in this scenario, the svm and nb models are the best for this data becuase it had the highest level of prediction (80%/80% v 78%) based on the constant variables and contraints that we put for each model. Additionally, they also had the highest number of correctly predicted values. HOWEVER, because in this round of testing we're using random samples of numbers for each model, the prediction levels will be different, so overall all the models would be the best fit for the data because they all have similar accurate rates of predictions over mutliple random samples. 






