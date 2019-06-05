# install.packages("ggplot2")
# install.packages("GGally")
# install.packages("DMwR")
# install.packages("factoextra")
# install.packages("NbClust")
# install.packages("tidyverse")
# install.packages("cluster")

setwd("D:/r-workspace/Assignments/Assignment1")

library(ggplot2)
library(GGally)
library(DMwR)
library(factoextra) # clustering algorithms & visualization
library(NbClust)
library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms

set.seed(5580)

#Original Data

prod = read.csv('productcluster.csv')
View(prod)

ggpairs(prod[,which(names(prod)!="StockCode")], upper = list(continuous = ggally_points),
        lower = list(continuous = "points"), title = "Products Before Outlier Removal")

#Clean Data - Remove Outliers

prod.clean <- prod[prod$StockCode != "47556B", ]
prod.clean <- prod.clean[prod.clean$StockCode != "23005", ]
prod.clean <- prod.clean[prod.clean$StockCode != "84568", ]
prod.clean <- prod.clean[prod.clean$StockCode != "DOT", ]

View(prod.clean)

ggpairs(prod.clean[,which(names(prod.clean)!="StockCode")], upper = list(continuous = ggally_points),
        lower = list(continuous = "points"), title = "Products After Outlier Removal")

#Scale Data

prod.scale = scale(prod.clean[-1]) 

#Plot Clusters

fviz_nbclust(prod.scale, kmeans, method = "wss") +
  geom_vline(xintercept = 5, linetype = 2)+
  labs(subtitle = "Elbow method")

fviz_nbclust(prod.scale, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method") #Checks for the lowerst value which indicates low overlaps

set.seed(5580)
pkm_experiment = kmeans(prod.scale, 5, 150)
fviz_cluster(pkm_experiment, data = prod.scale)

#K-Means

#Test one K-Means

set.seed(5580)
pkm = kmeans(prod.scale, 5, 150)
prod.realCenters = unscale(pkm$centers, prod.scale) 

clusteredProd = cbind(prod.clean, pkm$cluster)
#View(clusteredProd)
plot(clusteredProd[,2:5], col=pkm$cluster)
write.csv(clusteredProd, file ='productcluster1.csv',col.names = FALSE)

#-------------------------------------------------------------------------------------

#Test Multiple K-Means

pkm4 = kmeans(prod.scale, 4, 150)
prod.realCenters = unscale(pkm4$centers, prod.scale) 

clusteredProd = cbind(prod.clean, pkm4$cluster)
#View(clusteredProd)
plot(clusteredProd[,2:5], col=pkm4$cluster)

pkm5 = kmeans(prod.scale, 5, 150)
prod.realCenters = unscale(pkm5$centers, prod.scale) 

clusteredProd = cbind(clusteredProd, pkm5$cluster)
#View(clusteredProd)
plot(clusteredProd[,2:5], col=pkm5$cluster)

write.csv(clusteredProd, file ='productcluster1.csv',col.names = FALSE)

# Extra 

#Scale Data

prod.scale = scale(prod.clean[-1]) 

#Plot Elow Graph

#Graph using withinSSrange

withinSSrange <- function(data,low,high,maxIter)
{
  withinss = array(0, dim=c(high-low+1));
  for(i in low:high)
  {
    withinss[i-low+1] <- kmeans(data, i, maxIter)$tot.withinss
  }
  withinss
} 

plot(withinSSrange(prod.scale,1,50,150))

#--------

#Graph using betterKmeans

prod.scale = scale(prod.clean[-1]) 

betterKmeans <- function(data,k,iter)
{
  ans = kmeans(data,k,iter)
  for(i in 1:10)
  {
    temp= kmeans(data,k,iter)
    if(temp$tot.withinss < ans$tot.withinss)
    {
      ans = temp
    }
  }
  ans
}

rightK <- function(data,lo,hi, iter)
{
  err=array((hi-lo+1)*2,dim=c((hi-lo+1),2))
  for(i in lo:hi)
  {
    rowNum=i-lo+1
    err[rowNum,1]=i
    err[rowNum,2]=betterKmeans(data,i,iter)$tot.withinss
  }
  err
}

plot(rightK(prod.scale,1,50,150))

#-----------

fviz_nbclust(prod.scale, kmeans, method = "wss") +
  geom_vline(xintercept = 6, linetype = 2)+
  labs(subtitle = "Elbow method")

# Silhouette method
fviz_nbclust(prod.scale, kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")

# Gap statistic
# nboot = 50 to keep the function speedy. 
# recommended value: nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(5580)
fviz_nbclust(prod.scale, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")

#-----------

prod = read.csv('productcluster1.csv')
View(prod)