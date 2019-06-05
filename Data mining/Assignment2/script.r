setwd("F:/SMU2/Data mining/Assignment2")
carData = read.csv("car.csv")
View(carData)
x = carData[,0:5]
y = carData[,6]
View(x)
View(y)

#Try rpart
#install.packages("rpart")
library(rpart)
treeCar = rpart(shouldBuy~.,data=carData,method="class",control=rpart.control(minsplit=10))
treeCar
predBuy = predict(treeCar,newdata=carData,type="class")
head(predBuy)
treeCM = table(carData[,"shouldBuy"],predBuy)
treeCM
sum(diag(treeCM)/sum(treeCM))
#install.packages("pROC")
library(pROC)
predCarProb = predict(treeCar,newdata = carData, type="prob")
predCarProb
roc(carData[,"shouldBuy"],predCarProb[,2])
plot(roc(carData[,"shouldBuy"],predCarProb[,2]))

#RandomForest
#install.packages("randomForest")
library(randomForest)
rf = randomForest(x,y)
rf
rfp = predict(rf,x)
rfCM = table(rfp,y)
sum(diag(rfCM))/sum(rfCM)
rfProb = predict(rf,x,type="prob")
roc(carData[,"shouldBuy"],rfProb[,2])
plot(roc(carData[,"shouldBuy"],rfProb[,2]))


rf = randomForest(x,y,nodesize = 50)
rf
rfp = predict(rf,x)
rfCM = table(rfp,y)
sum(diag(rfCM))/sum(rfCM)
rfProb = predict(rf,x,type="prob")


#sensitivity is the ability to correctly identify a given class
#specificity is the ability to correctly identify those who are in the different class(es)
#Hear, we are using the second column that menas class 'M'

#if we have more than two classes you need to use multiclass.roc
roc(carData[,"shouldBuy"],rfProb[,2])
plot(roc(carData[,"shouldBuy"],rfProb[,2]))

#if you have more than 2 classes, you can run this separately for each class
plot(roc(carData[,"shouldBuy"],rfProb[,1]))
plot(roc(carData[,"shouldBuy"],rfProb[,2]))
plot(roc(carData[,"shouldBuy"],rfProb[,3]))
plot(roc(carData[,"shouldBuy"],rfProb[,4]))


rf = randomForest(x,y,nodesize = 10)
rf
rfp = predict(rf,x)
rfCM = table(rfp,y)
sum(diag(rfCM))/sum(rfCM)
rfProb = predict(rf,x,type="prob")
roc(carData[,"shouldBuy"],rfProb[,2])
plot(roc(carData[,"shouldBuy"],rfProb[,2]))


#use caret package for 10 fold cross validation
#install.packages("caret")

library(caret)
control = trainControl(method="repeatedcv",number=10, repeats=3)
seed = 7
metric = "Accuracy"
set.seed(seed)
#install.packages("e1071")
library(e1071)
rf_default = train(x,y,method="rf",metric=metric,trControl=control)
library(caret)
control = trainControl(method='repeatedcv',number=10,repeats=3)
rf_default = train(x,y, method="rf",metric=metric,trControl=control)
print(rf_default)
varImp(rf_default)
ggplot(varImp(rf_default))