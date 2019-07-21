# If you are on linux you can uncomment the following lines to run caret on multiple cores
#install.packages("doMC")
#install.packages("caret")
#library(doMC)
#registerDoMC(4)
library(caret)
setwd("/Users/mcda/Desktop/MLAssignment4")
getwd()
xy=read.table("hourlymatrix.txt",sep=' ',header=F)
y=xy[,8]
head(y)
x=xy[,1:7]

# Using pre-sliced data
myCvControl <- trainControl(method = "repeatedCV",
                            number=10,
                            repeats = 5)

# Linear regression
glmFitTime <- train(V8 ~ .,
                    data = xy,
                    method = "glm",
                    preProc = c("center", "scale"),
                    tuneLength = 10,
                    trControl = myCvControl)
glmFitTime
summary(glmFitTime)
y_hat = predict(glmFitTime, newdata = x)
mean(100*abs(y_hat-y)/y)
# Your error with linear regression

# Support Vector Regression
svmFitTime <- train(V8 ~ .,
                    data = xy,
                    method = "svmRadial",
                    preProc = c("center", "scale"),
                    tuneLength = 10,
                    trControl = myCvControl)
svmFitTime
summary(svmFitTime)
y_hat = predict(svmFitTime, newdata = x)
mean(100*abs(y_hat-y)/y)
# Your error with support vector regression

# Neural Network
nnFitTime <- train(V8 ~ .,
                   data = xy,
                   method = "avNNet",
                   preProc = c("center", "scale"),
                   trControl = myCvControl,
                   tuneLength = 10,
                   linout = T,
                   trace = F,
                   MaxNWts = 10 * (ncol(xy) + 1) + 10 + 1,
                   maxit = 500)
nnFitTime
summary(nnFitTime)
y_hat = predict(nnFitTime, newdata = x)
mean(100*abs(y_hat-y)/y)
# Your error with neural networks

# You can experiment with other methods, here is where you can find the methods caret supports:
# https://topepo.github.io/caret/available-models.html

# Compare models
resamps <- resamples(list(lm = glmFitTime,
                          svn = svmFitTime,
                          nn = nnFitTime))
summary(resamps)


# Now working with the time-series modeling

# Your Arima error