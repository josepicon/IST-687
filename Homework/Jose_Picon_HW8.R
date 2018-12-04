#Week 8: Making Predictions 

library(readxl)
library(ggplot2)

#1, #2: Read and access the data
setwd("/Users/josepicon/Desktop/Projects /IST 687")
df <- read_xls("mlr01.xls")

#3: inspect the data 
str(df)

#4: create bivariate plots of number of baby fawns versus antelope population, the	precipitation	that	year,	and	the	severity	of	the	winter.	Your	code	should	produce	three	separate	plots. make sure the y and x axis are labeled 

colnames(df) <- c("fawns", "adults", "percipitation", "winter")

fva <- ggplot(df, aes(x = fawns, y=adults)) + geom_point()
fva + stat_smooth(method = "lm", col = "red")

fvp <- ggplot(df, aes(x = fawns, y=percipitation)) + geom_point()
fvp + stat_smooth(method = "lm", col = "red")

fvw <- ggplot(df, aes(x = fawns, y=winter)) + geom_point()
fvw + stat_smooth(method = "lm", col = "red")


#5: create	three	regression	models	of	increasing	complexity	using	lm().

#In	the	first	model, predict	the	number	of	fawns	from	the	severity	of	the	winter

fvw.ml = lm(formula = fawns ~ winter, data = df)
plot(df$fawns, df$winter)
abline(fvw.ml)
predict(fvw.ml)
summary(fvw.ml)

#In	the	second	model,	predict	the	number	of	fawns from	two	variables	(one	should	be	the	severity of	the	winter

fvwa.ml = lm(formula = fawns ~ winter + adults, data = df)
summary(fvwa.ml)
predict(fvwa.ml)

#	In	the	third	model	predict	the	number	of	fawns from	the	three	other variables.

fvall.ml = lm(formula = fawns ~ winter + adults + percipitation, data = df)
summary(fvall.ml)
predict(fvall.ml)

#which model works best: the third model works best becuase it has the highest level of predictibility with the lowest p-value 

#which of the predictors are statistically significant in each model: for the first model, the only predictor, winter, is not statistically significant as is has an estimated standard error of .33. In the second model, winter is slighly statistically since its close to the standard .05 target of standard error, which is at .07. In the third model, none of the predictiros are are statisitcally significant because they are all above the .05 target of standard error.  

#parasimonious model would contain: I would use adults to predict the number of fawns because these are the two comparable values with the lowest individual p-values (.0001 & 0.03), and highest R-sqaured value (.86). Winter provides a p-value of 0.3 and R-squared of .47, percipitation provides a p-value of 0.001 and R-squared of .82; as a result, the best model using just one factor would be: fvt.ml = lm(formula = fawns ~ adults , data = df). 

