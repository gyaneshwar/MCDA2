# install.packages("ggplot2")
# install.packages("GGally")
# install.packages("DMwR")

library(ggplot2)
library(GGally)
library(DMwR)

set.seed(5580)

#Original Data

cust = read.csv('customercluster.csv')
View(cust)

ggpairs(cust[,which(names(cust)!="CustomerID")], upper = list(continuous = ggally_points),
        lower = list(continuous = "points"), title = "Customers Before Outlier Removal")

#Clean Data - Remove Outliers

cust.clean <- cust[cust$CustomerID != "0", ]
cust.clean <- cust.clean[cust.clean$CustomerID != "14646", ]

#View(cust.clean)

ggpairs(cust.clean[,which(names(cust.clean)!="CustomerID")], upper = list(continuous = ggally_points),
        lower = list(continuous = "points"), title = "Customers After Outlier Removal")

#Scale Data

cust.scale = scale(cust.clean[-1]) 

withinSSrange <- function(data,low,high,maxIter)
{
  withinss = array(0, dim=c(high-low+1));
  for(i in low:high)
  {
    withinss[i-low+1] <- kmeans(data, i, maxIter)$tot.withinss
  }
  withinss
} 

plot(withinSSrange(cust.scale,1,50,150))

pkm = kmeans(cust.scale, 6, 150)
cust.realCenters = unscale(pkm$centers, cust.scale) 

clusteredCust = cbind(cust.clean, pkm$cluster)
#View(clusteredCust)
plot(clusteredCust[,2:5], col=pkm$cluster)
write.csv(clusteredCust, file ='customercluster1.csv',col.names = FALSE)

cust = read.csv('customercluster1.csv')
View(cust)