#install.packages("rpart")
#install.packages("pROC")
#install.packages("randomForest")
#install.packages("caret")

setwd("D:/r-workspace/Assignments/Assignment2")

library(rpart)
library(pROC)
library(randomForest)
library(caret)

carData=read.csv("car.csv")
summary(carData)
View(carData)
x=carData[,1:6]
y=carData[,7]
#View(x)
#View(y)

# Try rpart

library(rpart)
treeCar = rpart(shouldBuy~.,data=carData,method="class",control=rpart.control(minsplit=10))
treeCar
plot(treeCar)
text(treeCar)
title(main = "Decision Tree")
predCar=predict(treeCar,newdata=carData,type="class")
head(predCar)
treeCM=table(carData[,7],predCar)
treeCM
#Accuracy of the prediction using decision tree
sum(diag(treeCM))/sum(treeCM)
library(pROC)
predCarProb=predict(treeCar,newdata=carData,type="prob")
roc(carData[,7],predCarProb[,2]) # what is this 2 ? *****
plot(roc(carData[,7],predCarProb[,2]))

#Try randomForest
library(randomForest)
rf=randomForest(x,y)
rfp=predict(rf,x)
rfCM=table(rfp,y)
rfCM
#Accuracy of the prediction using randomForest
sum(diag(rfCM))/sum(rfCM)
rfProb=predict(rf,x,type="prob")
roc(carData[,7],rfProb[,2])
plot(roc(carData[,7],rfProb[,2]))

rf=randomForest(x,y,nodesize=50) # what is nodesize ? *****
rfp=predict(rf,x)
rfCM=table(rfp,y)
rfCM
#Accuracy of the prediction using randomForest and node 50
sum(diag(rfCM))/sum(rfCM)
rfProb=predict(rf,x,type="prob")

# sensitivity is the ability to correctly identify a given class
# specificity is the ability to correctly identify those who are in different class(es)
# Here, we are using the second column that means class 'M'

# If we have more than two classes you need to use multiclass.roc
# roc(carData[,7],rfProb[,2])

# plot(roc(carData[,7],rfProb[,2]))
# title(main = "RandomForest Probability using 50 node (Class 2)")

# If you have more than two classes, you can run this separately for each class
roc(carData[,7],rfProb[,1])
plot(roc(carData[,7],rfProb[,1]))
title(main = "RandomForest Probability using 50 node (Class 1)")
roc(carData[,7],rfProb[,2])
plot(roc(carData[,7],rfProb[,2]))
title(main = "RandomForest Probability using 50 node (Class 2)")
roc(carData[,7],rfProb[,3])
plot(roc(carData[,7],rfProb[,3]))
title(main = "RandomForest Probability using 50 node (Class 3)")
roc(carData[,7],rfProb[,4])
plot(roc(carData[,7],rfProb[,4]))
title(main = "RandomForest Probability using 50 node (Class 4)")

rf=randomForest(x,y,nodesize=10)
rfp=predict(rf,x)
rfCM=table(rfp,y)
rfCM
#Accuracy of the prediction using randomForest and node 10
sum(diag(rfCM))/sum(rfCM)
rfProb=predict(rf,x,type="prob")
#roc(carData[,7],rfProb[,2])
#plot(roc(carData[,7],rfProb[,2]))

# If you have more than two classes, you can run this separately for each class
roc(carData[,7],rfProb[,1])
plot(roc(carData[,7],rfProb[,1]))
title(main = "RandomForest Probability using 10 node (Class 1)")
roc(carData[,7],rfProb[,2])
plot(roc(carData[,7],rfProb[,2]))
title(main = "RandomForest Probability using 10 node (Class 2)")
roc(carData[,7],rfProb[,3])
plot(roc(carData[,7],rfProb[,3]))
title(main = "RandomForest Probability using 10 node (Class 3)")
roc(carData[,7],rfProb[,4])
plot(roc(carData[,7],rfProb[,4]))
title(main = "RandomForest Probability using 10 node (Class 4)")

# Use caret package for 10 fold cross validation
library(caret)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 7
metric <- "Accuracy"
set.seed(seed)
rf_default <- train(x,y, method="rf", metric=metric, trControl=control)
library(caret)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
rf_default <- train(x,y, method="rf", metric=metric, trControl=control)
print(rf_default)
varImp(rf_default)
ggplot(varImp(rf_default))

#-------------------------------------------

#Extra

