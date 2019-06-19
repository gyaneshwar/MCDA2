# install.packages("rpart")
# install.packages("pROC")
# install.packages('caTools')
# install.packages("randomForest")
# install.packages("caret")
# install.packages("e1071")
# install.packages("ggplot2")

setwd("F:/SMU2/Data mining/Assignment2")
#-----------------Decision tree----------------------#
#           
#       RPART
#
#
library(rpart)
library(pROC)
library(randomForest)
library(caret)
library(ggplot2)
set.seed(123)
carData=read.csv("car.csv")
summary(carData)
# View(carData)

x=carData[,1:6]
y=carData[,7]

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(carData$shouldBuy, SplitRatio = 0.75)
training_set = subset(carData, split == TRUE)
test_set = subset(carData, split == FALSE)

list_data <- c()


#-----------------Decision Tree , Evaluating accuracy for different minsplit -------------------#

library(rpart)
for (i in seq(0, 1000, 10)){
  treeCar = rpart(shouldBuy~.,data=training_set,method="class",control=rpart.control(minsplit=i))
  #Pridiction
  predCar=predict(treeCar,training_set,type="class")
  #Matrix
  treeCM=table(training_set[,7],predCar)
  treeCM
  #Accuracy
  accuracy = sum(diag(treeCM))/sum(treeCM)
  list_data <- c(list_data,accuracy)
}

temp_list_data <- c(seq(0, 1000, 10)) 
temp_list_data
list_data
plot(y=list_data,x=temp_list_data,
     main = "Decision Tree - Accuracy measure with Minsplit [0,1000]",
     ylab = "Accuracy",
     xlab = "Min Split Value")


#-----------------Decision Tree , choosing minsplit as 140 ---------------------------------#
library(rpart)
treeCar = rpart(shouldBuy~.,data=training_set,method="class",control=rpart.control(minsplit=140))
treeCar

predCar=predict(treeCar,training_set,type="class")
#Matrix
treeCM=table(training_set[,7],predCar)
treeCM
#Accuracy of the prediction using Decision Tree
accuracy=sum(diag(treeCM))/sum(treeCM)

#-----------------Decision Tree , ROC curves ---------------------------------#

predCar_prob=predict(treeCar,training_set,type="prob")

roc_1 = roc(training_set[,"shouldBuy"],predCar_prob[,1],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_1)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")


roc_2 = roc(training_set[,"shouldBuy"],predCar_prob[,2],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_2)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")

roc_3 = roc(training_set[,"shouldBuy"],predCar_prob[,3],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_3)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")

roc_4 = roc(training_set[,"shouldBuy"],predCar_prob[,4],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_4)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")

#-----------------Decision Tree , K Fold ---------------------------------#

library(caret)
library(e1071)
control <- trainControl(method="cv", number=10, savePredictions=TRUE)
seed <- 123
metric <- "Accuracy"
set.seed(seed)
rf_default <- train(x,y, method="rpart", metric=metric, control = rpart.control(minsplit = 140), 
                    trControl=control)
print(rf_default)
varImp(rf_default)
p = ggplot(varImp(rf_default))
p + ggtitle("rpart variable importance in a model")


#----------------------------------------------------------------#
# Random Forest
# 
# 
setwd("F:/SMU2/Data mining/Assignment2")

library(rpart)
library(pROC)
library(randomForest)
library(caret)

carData=read.csv("car.csv")
summary(carData)

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(carData$shouldBuy, SplitRatio = 0.75)
training_set = subset(carData, split == TRUE)
test_set = subset(carData, split == FALSE)

x=training_set[,1:6]
y=training_set[,7]

list_data <- c()

#-------------Random Forest optimal ntree-------------#

library(randomForest)
for (i in seq(100, 700, 10)){
  rf=randomForest(x,y, ntree=i)
  rfp=predict(rf,x)
  rfCM=table(rfp,y)
  accuracy = sum(diag(rfCM))/sum(rfCM)
  list_data <- c(list_data,accuracy)
}

temp_list_data <- c(seq(100, 700, 10)) 
temp_list_data
list_data
plot(y=list_data,x=temp_list_data,
     main = "Random forest - Accuracy measure with ntree [100,700]",
     ylab = "Accuracy",
     xlab = "ntree")

#------------Random Forest , choose ntree 260 as the accuracy 1--------#

x=training_set[,1:6]
y=training_set[,7]

rf=randomForest(x,y, ntree=260)
rfp=predict(rf,test_set[,1:6])
rfCM=table(rfp,test_set[,7])
rfCM
#Accuracy of the prediction using randomForest
accuracy = sum(diag(rfCM))/sum(rfCM)
accuracy

#------------Random Forest ROC curves ---------------#
rf_prob = predict(rf,x,type="prob")


roc_1 = roc(training_set[,"shouldBuy"],rf_prob[,1],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_1)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")


roc_2 = roc(training_set[,"shouldBuy"],rf_prob[,2],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_2)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")

roc_3 = roc(training_set[,"shouldBuy"],rf_prob[,3],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_3)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")

roc_4 = roc(training_set[,"shouldBuy"],rf_prob[,4],smoothed = TRUE,
            # arguments for ci
            ci=TRUE, ci.alpha=0.9, stratified=FALSE,
            # arguments for plot
            plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
            print.auc=TRUE, show.thres=TRUE)
sens.ci <- ci.se(roc_4)
plot(sens.ci, type="shape", col="lightblue")
## Warning in plot.ci.se(sens.ci, type = "shape", col = "lightblue"): Low
## definition shape.
plot(sens.ci, type="bars")



#-------Random Foresh K fold----------------------------#

x=carData[,1:6]
y=carData[,7]

# Use caret package for 10 fold cross validation
library(caret)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 123
metric <- "Accuracy"
set.seed(seed)
rf_default <- train(x,y, method="rf",ntree = 260, metric=metric, trControl=control)
print(rf_default)
varImp(rf_default)
ggplot(varImp(rf_default))+ggtitle("Random Forest variable importance in a model")


