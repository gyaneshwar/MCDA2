# install.packages("ggplot2")
# install.packages("GGally")
# install.packages("DMwR")

library(ggplot2)
library(GGally)
library(DMwR)

set.seed(5580)

#Original Data

prod = read.csv('F:/SMU2/Data mining/Assignment 1/Assignment1-Allen/Assignment1/productcluster.csv')
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
prod.scale
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
pkm$centers
prod.realCenters = unscale(pkm$centers, prod.scale) 
prod.realCenters
clusteredProd = cbind(prod.clean, pkm$cluster)
#View(clusteredProd)
plot(clusteredProd[,2:5], col=pkm$cluster)
write.csv(clusteredProd, file ='productcluster1.csv',col.names = FALSE)

prod = read.csv('productcluster1.csv')
View(prod)