setwd("F:/SMU2/Data mining/Assignment3/")
getwd()
install.packages("arules")
library("arules")
tr=read.transactions("temp.csv",,format="basket",sep=" ")
tr
rules = apriori(tr, parameter= list(supp=0.004, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.2, conf=0.5))
rules = apriori(tr, parameter= list(supp=0.1, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.01, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.05, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.03, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.25, conf=0.5))
inspect(rules)
setwd("F:/SMU2/Data mining/Assignment3/")
getwd()
install.packages("arules")
library("arules")
tr=read.transactions("temp.csv",,format="basket",sep=" ")
tr
rules = apriori(tr, parameter= list(supp=0.004, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.2, conf=0.5))
rules = apriori(tr, parameter= list(supp=0.1, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.01, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.05, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.03, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.01, conf=0.5))
inspect(rules)
rules = apriori(tr, parameter= list(supp=0.001, conf=0.5))
inspect(rules)