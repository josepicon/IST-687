#Week 8: Making Predictions 

library(readxl)
library(ggplot2)

#Read the data
setwd("/Users/josepicon/Desktop/Projects /IST 687")
df <- read_xls("mlr01.xls")

#inspect the data 
str(df)

#create bivariate plots of number of baby fawns versus antelope population, the	precipitation	that	year,	and	the	severity	of	the	winter.	Your	code	should	produce	three	separate	plots. make sure the y and x axis are labeled 

colnames(df) <- c("fawns", "adults", "percipitation", "winter")
View(df)

fva <- ggplot(df, aes(x = fawns, y=adults)) + geom_point()
fva + stat_smooth(method = "lm", col = "red")

fvp <- ggplot(df, aes(x = fawns, y=percipitation)) + geom_point()
fvp + stat_smooth(method = "lm", col = "red")

fvw <- ggplot(df, aes(x = fawns, y=winter)) + geom_point()
fvw + stat_smooth(method = "lm", col = "red")


#create	three	regression	models	of	increasing	complexity	using	lm().


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

#which of the predictors are statistically significant in each model: 

#parasimonious model would contain: 
