library(ggplot2)
 
oilchange <- c(1:10)
repairs <- c(15,12,8,5,4,4,5,3,2,2)
 
 df <- data.frame(oilchange, repairs)
 plot(df$oilchange, df$repairs)
 
m <- lm(repairs ~ oilchange, data = df)
 
summary(m)

#p-value = 1 is 100% of data is random, the lower the number the better (best practice is no more than 5%, trust model with 95% certainty) -- use this model to predict the dependent varriables (statistical significance)

#adjusted r-squared = 1 or close to 1, high correlation to identify depdendent variable with independent variable 

abline(m)
#use this line to make future predictions 
g <- ggplot(df, aes(x = oilchange, y=repairs)) + geom_point()
g
g + stat_smooth(method = "lm", col = "red")

predict(m)


#use mtcars dataset to predict the mpg using other varaibles 

mpg.ml = lm(formula = mpg ~ wt, data = mtcars)
summary(mpg.ml)

plot(mtcars$wt, mtcars$mpg)

abline(mpg.ml)
summary(mpg.ml)

mpg.ml = lm(formula = mpg ~ wt + hp, data = mtcars)
summary(mpg.ml)

#more data does not always mean better results, regression models might get confused to go towards all the varaibles, machine learning models is to figure out which features or variables that would predict your dependent variable 

#the ones with high adjusted r squared (predictability) would be used in the prediction model 

#ARsquared: if 100%, all the number of repairs can be explained (or defined) by the oil change, how much of that dependent varaible can be explained by the independent variable 


