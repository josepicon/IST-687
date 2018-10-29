 myCars <- mtcars

 max(myCars$hp)

 index <- which.max(myCars$hp) 
Myrnames <- rownames(myCars[index,]) 
Myrnames

max(myCars$mpg)

index <-which.max(myCars$mpg)

sortedMPG <- myCars[order(-myCars$mpg),]
sortedMPG

#Question6
myCars$mpgAndHp <- c(myCars$mpg * myCars$hp)
MyIndex <- which.max(myCars$mpgAndHp)
rownames(myCars[MyIndex,])

#Step 4 
myCars$scaleMPG <- scale(myCars$mpg)
myCars$scaleHP <- scale(myCars$hp)

myCars$scaleMPGAndHp <- myCars$scaleMPG + myCars$scaleHP

#find the car with the best combination
MyIndex <- which.max(myCars$scaledMPGandHP)
rownames(myCars[MyIndex,])

