#9.8, SVM example

install.packages("kernlab")
library(kernlab)
data(spam)
str(spam)

table(spam$type)

#divide into a "training" and "test" dataset: 2/3 training, 1/3 test
#create a 2/3 cut point, crease trainData and testData and the previously created random indexes 

#create list/vector variable-random index 
randIndex <- sample(1:dim(spam)[1])

summary(randIndex)
length(randIndex)
head(randIndex)

#create 2/3 cut point 
cutpoint2_3 <- floor(2 * dim(spam)[1]/3)

#create training data set 
trainData <- spam[randIndex[1:cutpoint2_3],]

#create test data
testData <- spam[randIndex[(cutpoint2_3+1):dim(spam)[1]],]

#train support vector model 
svmOutput <- kvsm(type ~.,
                  data=trainData, 
                  kernel="rbfdot", 
                  kpar="automatic", 
                  C= 5,
                  cross =3,
                  prob.model=TRUE
)

#cost parameter: balance the cost to make a trade-off, helps us understand out to deal with outliars. 

#High C: fewer mistakes, smaller margins of separation, specialized, high cross-validation error, lower training error 

#lower C: more mistakes, higher margin of separation, generalized model, lower cross-validation error, higher training error 

#C = 3
svmOutput
#training error: 0.03 (3%)

#C = 50 
svmOutput
#training error: 0.01 (1%), might have issues when testing 

#predict "testData" where svmOutput had C=5 

svmPred <- predict(svmOutput, testData, type="votes")
compTable <- data.frame(testData[,58], svmPred[1,])

table(compTable)

#interpretation(9.8 SVM example, 12m): 33 cases not spam but classified as spam, 884 cases not spam and classified as not spam, 551 cases spam and classified as spam, 66 cases classified as spam but not spam) 
#33 + 66 = 99 error cases, 99/154 = .058 error rate %, 94.2% accurary rate
 



