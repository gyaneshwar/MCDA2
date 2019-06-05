data = read.table("syn.csv",sep='\t',header=F)
head(data)
summary(data)

source("betterKmeans.r")

for(i in lo:hi)
{
	rowNum=i-lo+1
	err[rowNum,1]=i
	err[rowNum,2]=betterKmeans(data,i,100)$tot.withinss
}
write.csv(err,file="errors.csv")

# Plot the errors and see the knee of the curve

cust = read.table(file="customer.csv",header=T,sep='\t')

kmC=kmeans(cust[,2:ncol(cust)],5,100)
kmC
kmC$centers
kmC$size
summary(cust)
custNorm=cust
custNorm[,2]=cust[,2]/mean(cust[,2])
custNorm[,3]=cust[,3]/mean(cust[,3])
summary(custNorm)
custNorm[,2]=custNorm[,2]*2
summary(custNorm)
kmC=kmeans(custNorm[,2:ncol(custNorm)],5,100)
kmC$centers
centersReal = kmC$centers
centersReal
centersReal[,1]=mean(cust[,2])*centersReal[,1]/2
centersReal[,2]=mean(cust[,3])*centersReal[,2]

write.csv(centersReal,"centers.csv")
# Use the centers for writing profiles

write.csv(cbind(cust[,1],kmC$cluster),file="clusterMembership.csv")
# import the clusterMembership in your database and join them with
# the original dataset.
# You can use the joined dataset to drill down and summarize
# diffeerent characterstics for each cluster
# 1. What products do customers from a given cluster buy
# 2. Daily visit pattern for a cluster
# Anything else you can think of. Repeat it for the product cluster as well
