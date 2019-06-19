setwd("F:/saint mary 2nd sem/Assignment 1/Assignment1-Allen/Assignment1")
# install.packages("ggplot2")

#install.packages("lattice")
#install.packages("gridBase")
#install.packages("GGally") # OPTIONAL - only if you don't have
#install.packages("DMwR")   # OPTIONAL - only if you don't have
#install.packages("ggplot2")
#options(repos = getOption("repos")["CRAN"])
#pkgs <- c("factoextra",  "NbClust")
#install.packages(pkgs)
library(factoextra)
library(NbClust)
library(grid)
library(ggplot2)
library(GGally)
library(DMwR)

set.seed(5580)

#Original Data

prod = read.csv('products.csv')
View(prod)

ggpairs(prod[,which(names(prod)!="StockCode")], upper = list(continuous = ggally_points),
        lower = list(continuous = "points"), title = "Products Before Outlier Removal")

#Clean Data - Remove Outliers

prod.clean <- prod[prod$StockCode != "47556B", ]

#View(prod.clean)

ggpairs(prod.clean[,which(names(prod.clean)!="StockCode")], upper = list(continuous = ggally_points),
        lower = list(continuous = "points"), title = "Products After Outlier Removal")

#Scale Data

prod.scale = scale(prod.clean[-1]) 

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

pkm = kmeans(prod.scale, 6, 150)
prod.realCenters = unscale(pkm$centers, prod.scale) 

clusteredProd = cbind(prod.clean, pkm$cluster)
#View(clusteredProd)
plot(clusteredProd[,2:5], col=pkm$cluster)
#write.csv(clusteredProd, file ='productcluster1.csv',col.names = FALSE)

#prod = read.csv('productcluster1.csv')
View(prod)


#------------------
#---https://www.datanovia.com/en/lessons/determining-the-optimal-number-of-clusters-3-must-know-methods/
fviz_nbclust(prod.scale, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
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

fviz_nbclust(prod.scale, kmeans, method = c("silhouette", "wss", "gap_stat"))
#-----------------------------
#---https://uc-r.github.io/kmeans_clustering

library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization

distance <- get_dist(prod.scale)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
pkm_experiment = kmeans(prod.scale, 5, 150)
fviz_cluster(pkm_experiment, data = prod.scale)
#-------------------------------------------------------

library(cluster)
library(HSAUR)
data(pottery)
km    <- kmeans(prod.clean,6)
dissE <- daisy(pottery) 
dE2   <- dissE^2
sk2   <- silhouette(km$cl, dE2)
plot(sk2)
