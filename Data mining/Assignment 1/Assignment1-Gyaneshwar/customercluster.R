#Load All Libraries

install.packages("lattice")
install.packages("gridBase")
install.packages("GGally") # OPTIONAL - only if you don't have
install.packages("DMwR")   # OPTIONAL - only if you don't have
install.packages("ggplot2")
options(repos = getOption("repos")["CRAN"])
library(grid)
library(ggplot2)
library(GGally)
library(DMwR)

prod <- read.csv("D:/assignment/pawan/assignment1/customer_retail.csv") # You can use option "import Dataset" to import CSV file if you are getting path error

View(prod) # To View the loaded dataset
ggpairs(prod[, which(names(prod) != "CustomerID")], upper = list(continuous = ggally_points),lower = list(continuous = "points"), title = "Products before outlier removal") # To visualize data
boxplot(prod$baskets) # For Box and Whisker plot. here prod is dataset and BASKETS is column
prod.clean <- prod[prod$CustomerID != 0, ] # Remove outliers
prod.scale = scale(prod.clean[-1]) # Normalize data using scale and exclude ITEM_SK column. -1 will remove first column that is ITEM_SK and keep all other.

View(prod.scale)

withinSSrange <- function(data,low,high,maxIter)
{
  withinss = array(0, dim=c(high-low+1));
  for(i in low:high)
  {
    withinss[i-low+1] <- kmeans(data, i, maxIter)$tot.withinss
  }
  withinss
}       

plot(withinSSrange(prod.scale,1,50,150)) # Elbow plot to determine the optimal number of clusters between 1 and 50.
# plot mentions 6 to 9 are good clusters to consider.
pkm = kmeans(prod.scale, 6, 150) # K-means using k=6 for products based on results of  elbow plot.
View(pkm)
prod.realCenters = unscale(pkm$centers, prod.scale) # Denormalize data by reversing scale function

clusteredProd = cbind(prod.clean, pkm$cluster) # Bind clusers to cleansed Data
View(clusteredProd)
plot(clusteredProd[,2:5], col=pkm$cluster) # Visualizing clusering results. Here we want all rows so we are not mentioning anything but we want columns only from 2 to 5 (we don't want to visualize first column - CustomerID).