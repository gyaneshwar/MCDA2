# If you are on linux you can uncomment the following lines to run caret on multiple cores
#install.packages("doMC")
#install.packages("caret")
#library(doMC)
#registerDoMC(4)
library(caret)
setwd("F:/SMU2/Data mining/MLAssignment4/")
getwd()
xy=read.table("hourlymatrix.txt",sep=' ',header=F)
y=xy[,8]
head(y)
x=xy[,1:7]

# Using pre-sliced data
# method = the resampling method is repeatedcv.
# K-fold , dividing the training set into 10 parts.
# number = is number of folds or number of resampling iterations.
# repeats= for repeated k-fold cross-validation only: the number of complete sets of folds to compute.

myCvControl <- trainControl(method = "repeatedcv",
                            number = 10,
                           repeats = 5)
# Linear regression 
# glm (Generalized linear model)
# Cross-Validated (10 fold)
# RMSE = Root mean square deviation or Root mean square error 
# Math.sqrt(Sigma[0 - n](values predicted - values observed)^2)
# MAE = computes the average absolute difference between two numeric vectors

glmFitTime <- train(V8 ~ .,
                    data = xy,
                    method = "glm",
                    preProc = c("center", "scale"),
                    tuneLength = 10,
                    trControl = myCvControl)
print(glmFitTime)
summary(glmFitTime)
y_hat = predict(glmFitTime, newdata = x)
summary(y_hat)
mean(100*abs(y_hat-y)/y)#12.63
# Your error with linear regression

# Support Vector Machine Radial
svmFitTime <- train(V8 ~ .,
                    data = xy,
                    method = "svmRadial",
                    preProc = c("center", "scale"),
                    #tuneLength = 10,
                    trControl = myCvControl)
svmFitTime
summary(svmFitTime)
y_hat = predict(svmFitTime, newdata = x)
mean(100*abs(y_hat-y)/y) #9.078736
# Your error with support vector regression

# Neural Network
nnFitTime <- train(V8 ~ .,
                   data = xy,
                   method = "avNNet",
                   preProc = c("center", "scale"),
                   trControl = myCvControl,
                   #tuneLength = 10,
                   linout = T,
                   trace = F,
                   MaxNWts = 10 * (ncol(xy) + 1) + 10 + 1,
                   maxit = 500)
nnFitTime
summary(nnFitTime)
y_hat = predict(nnFitTime, newdata = x)
mean(100*abs(y_hat-y)/y)#10.84375
# Your error with neural networks

# You can experiment with other methods, here is where you can find the methods caret supports:
# https://topepo.github.io/caret/available-models.html

# Compare models
resamps <- resamples(list(lm = glmFitTime,
                          svn = svmFitTime,
                          nn = nnFitTime))
summary(resamps)


# Now working with the time-series modeling

t= read.csv("15minutes.csv",header=FALSE)
head(t)
tSeries = ts(t,freq=4)
head(tSeries)
plot.ts(tSeries)
time(tSeries)
quantile(tSeries)
plot(decompose(tSeries))
plot(diff(tSeries))
ggseasonplot(tSeries)
adf.test(tSeries)

#install.packages("forecast")
library(forecast)
hw = ets(tSeries,model="MAM")
#MAM is multiplicative holt-winters method
#with multiplicative errors and so on.
mean(100*abs(fitted(hw) - tSeries)/tSeries)
#12.75735
# Your Holt-Winters error

ar <- Arima(tSeries,order=c(1,0,2))
mean(100*abs(fitted(ar) - tSeries)/tSeries)
#13.50665
# Your Arima error

res = auto.arima(tSeries, stepwise = F, approximation = F)
res
