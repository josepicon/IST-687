#3.7 Using Descriptive Stats

a <- rnorm(100, 50, 2) #number, mean, standard deviation
str(a)
hist(a)

hist(rnorm(100,50,2))
hist(rnorm(100000,50,2))

b<- rnorm(100000,50,2)
str(b)
mean(b)
sd(b)
hist(b)

hist(rnorm(100000,75,10)) 

c<- (rnorm(100000,75,2)) 
d <- c[c>80]
mean(d)

d <- c[c>82.5]
hist(d)
