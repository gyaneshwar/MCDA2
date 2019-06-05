#history() or history(20) to get history
tab=read.table("play.csv",header=TRUE,sep=',')
tab
library(rpart)
fit=rpart(Play~Outlook+Temperature+Humidity+Wind,data=tab,method="class",control=rpart.control(minsplit=1))
fit
plot(fit, uniform=TRUE, main="Decision Tree ­ Play?")
text(fit,use.n=TRUE,all=TRUE,cex=.8)
summary(fit)
pred=predict(fit,newdata=tab,type="class")
#Confusion matrix
mc=table(tab$Play,pred)
mc
fit2=rpart(Play~Outlook+Temperature+Humidity+Wind,data=tab,method="class",control=rpart.control(minsplit=1))
fit2
pred2=predict(fit,newdata=tab,type="class")
#Confusion matrix
mc2=table(tab$Play,pred2)

tabNumber=read.table("playNumeric.csv",header=TRUE,sep=',')
fitNumber=rpart(Play~Outlook+Temperature+Humidity+Wind,data=tabNumber,
method="class",control=rpart.control(minsplit=1))
fitNumber
predNumber=predict(fitNumber,newdata=tabNumber,type="class")
mcNumber=table(tabNumber$Play,predNumber)
mcNumber


