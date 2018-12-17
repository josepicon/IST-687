#9.9, SVM example
install.packages("kernlab")
library(kernlab)

bank_data = read.csv(datafile, sep',', header=TRUE)
str(bank_data)
summary(bank_data)

nrows <- nrows(bank_data)

cutpoint <- floor(nrows/3*2)
cutpoint

rand <- sample(1:nrows)
bd.train <- bd[rand[1:cutpoint],]
bd.test <- bd[rand[(1:cutpoint+1):nrows],]
#1/3 should be test and 2/3 should be train 
str(bd.test)
str(bd.train)

model <- ksvm(y ~., data=db.train)

pred <- predict(model, bd.test)
results <- table(pred, bd.test$y)

#calculate the accuracy % 
totalCorrect <- results[3,1] + results [2,2]
totalInTest <- nrows(bd.test)
totalCorrect/totalInTest

#new model that predicts whether education will predict ontime on their load 

model.1 <- ksvm(y ~ education, data=db.train)
#training error: 11%
model.1

pred <- predict(model.1, bd.test)
results <- table(pred, bd.test$y)
totalCorrect <- results[3,1] + results [2,2]
totalInTest <- nrows(bd.test)
totalCorrect/totalInTest

#89% correct, error 
results 










