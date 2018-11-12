#4.5 Replicating Samples 

#Not interested in one sample, but what happens over time, i.e., many samples 

replicate(mean(replicate(4, mean(sample(USstatePops$april10census, size=16, replace = TRUE)),simplify = TRUE))
)

#draw 400 samples of size 16 from our state population 
#Calculate the mean from each sample and keep it in a list
#calculate the mean of the 400 sample means 
#calculated mean of means is off by ~40k 

mean(replicate(400, mean(sample(USstatePops$april10census, size=16, replace = TRUE)),simplify = TRUE))

#same but 4000 times 
mean(replicate(4000, mean(sample(USstatePops$april10census, size=16, replace = TRUE)),simplify = TRUE))
#closer to the mean of the population of 51 states

#Law of large numbers 

#if you run a stat process a large number of times it will converge on a stable result 

#Central Limit Theorm 

#When we look at sample means and take into account the "law of large numbers," the distribution of sampling means starts to create a normal distirbution (bell shaped curve), and the center of that distribution, the mean of the sample means, gets closer to the population mean

#Sampling Distribution 
samplemeans <- replicate(10000, mean(sample(USstatePops$april10census, size=120, replace = TRUE)),simplify = TRUE))

#Quantiles: 

#What percent of the population falls within a certain percentage

#Quantile function, similar to summary function
quantile(samplemeans, probs = 0.25, 0.75)
quantile(samplemeans, probs = 0.05, 0.95)
quantile(samplemeans, probs = 0.025, 0.975)



