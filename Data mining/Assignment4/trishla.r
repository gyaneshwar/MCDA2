#install.packages("caret")
library(caret)
setwd("/Users/mcda/Desktop/MLAssignment4")
getwd()
xy=read.table("hourlymatrix.txt",sep=' ',header=F)
x = xy[, 1:7]
head(x)
y = xy[, 8]
head(y)
myCvControl = trainControl(method = "repeatedCV",number=10,repeats = 5)
