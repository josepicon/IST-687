#Ch 9: Machine Learning 

#need packages, see sample code 

data("Groceries")
inspect(head(Groceries))

#how many times were each item bought 
itemFrequencyPlot(Groceries, support=0.05, cex.names=0.5)

#apriori is a common association rules miner, finds which items are most common, have to provide with support and confidence, can set up to return top 10 or top 20

ruleset <- apriori(Groceries, parameter = list(support = 0.005, confidence=0.5))
ruleset <- apriori(Groceries, parameter = list(support = 0.01, confidence=0.5))
summary(ruleset)
inspect(ruleset)
#inspect give the list of rules, where you need to pay most attention. Output: left hand side, right hand side, support, confidence, life, count. 
#Support, from all data records, what percentage represents this role
#confidence, from all the records in the left, what percentage has this right, this confidence will help you identify a response. eg.) backing powder -> whole milk -> .52 confidence; 52% who bought baking powder also bought whole milk 
#lift: how important is that confidence, the higher the lift the more significant the confidence 
#pay attention to those with high support (low number), high confidence, high lift




#maybe need to see which ones have the most lift 
ruleset <- apriori(Groceries, parameter = list(support = 0.005, confidence=0.35))
plot(ruleset)
goodrules <- ruleset[quality(ruleset)$lift>3]

#Step 1: 

#load the data 
#find which cols ahve NAs 
#find the NAs in Col solar R 

#Step 2: 
dim(air)
air[1:5,]
#select randomly from 1-153
randIndex <- sample(1:dim(air)[1])
head(randIndex)
length(randIndex)
air[148,]
air[45,]

#in order to split the data, create a 2/3 cutpoint and round the number 
#2 multiplied by 153 divided by 3, cutting point is 66%
cutpoint2_3 <- floor(2*dim(air)[1]/3)


trainData <- air[randIndex[1: cutpoint2_3],]
dim(trainData)
head(trainData)

#create test data, which contains the left 1/3 of the overall data 
testData <- air[randIndex[(cutpoint2_3+1):dim(air)[1]],]
#check test data set 
dim(trainData)
head(trainData)

#-----------------------------------lm model 
model <- lm(Ozone ~., data=trainData)
lmPred <- predict(model, testData)

str(lmPred) 
lmPred #the predicted values 
comptable3 <- data.frame(testData[,1], lmPred)
colnames(comptable3) <- c("test", "Pred")
#squareroot error rate, if close to 1, there is almost a match between predicted and actual, measures the performance of the model
sqrt <- (mean((comptable3$test-comptable3$Pred)^2))

#lm plot 
comptable3$error <- abs(comptable3$test - comptable3$Pred)
Plot3 <- data.frame 
#cont. 



#-------------------KSVM

svmOutput <- kvsm(Ozone~., #set "Ozone" as the target predicting variable  
                data = trainData,
                kernel = "rbfdot", #kernel functino that projects the low dimensional pr
                kpar = "automatic",
                cross = 10, 
                prob.model = TRUE)
#check these settings to best performance on model 
#check the model 
svmOutput

svmPred <- predict(svmOutput, #use the built model to predict
                   testData, 
                   type = "votes"
                   )
compTable <- data.frame((testData[,1], svmPred)[1])
compTable$error <- abs(compTable$test - compTable$Pred)
#cont.... 


#calculate average Ozone 
meanOzone <- mean(air$ozone,na.rm = TRUE)
# create a new varaible named "Good Ozone" in train data set 
 
trainData$goodOzone <- ifelse(trainData$Ozone<meanOzone,0,1)
trainData$goodOzone <- ifelse(trainData$Ozone<meanOzone,0,1)
#...cont 



svmGood <- ksvm
goodPred <- predict(svmGood, testData)
compGood1 <- data.frame(testData[,6], goodPred)

#predicting the accurary of the model 
perc_ksvm <- length(which(compGood1$test==compGood1$Pred))/dim(compGood1)[1]

#confusion matrix 

#
results <- table(test=compGood1$test, pred=compGood1$Pred)
print(results)


#------ SVM model 

svmGood <- svm(goodOzone~., data=trainData, kernel)