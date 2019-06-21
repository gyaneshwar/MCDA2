setwd("D:/Workspace/r-workspace/MCDA 5580/Assignment3")
getwd()

# install.packages("arules")
# install.packages("plyr", dependencies = TRUE)
library(arules)
library(plyr)

df_user= read.csv("temp.csv")
df_user <- df_user[df_user$InvoiceNo != "0", ]
View(df_user)
df_user = ddply(df_user,c("InvoiceNo"),function(dfl)paste(dfl$Description, collapse = ","))
df_user$InvoiceNo = NULL
df_user$StockCode = NULL
write.table(df_user,"Milestones2.csv", quote=FALSE, row.names = FALSE, col.names = FALSE)
tr = read.transactions("Milestones2.csv",format="basket",sep=",")
summary(tr)
itemFrequencyPlot(tr, topN=10)

#-------------------------------------------------------------
#supp = 0.03
rules = apriori(tr,parameter = list(supp=0.03,conf=0.5))
inspect(rules)
#supp = 0.03 (Gives No Rules)
#
#-------------------------------------------------------------
#supp = 0.02
rules = apriori(tr,parameter = list(supp=0.02,conf=0.5))
inspect(rules)
#supp = 0.02 (Gives 17 Rules)
#-------------------------------------------------------------
#supp = 0.015
rules = apriori(tr,parameter = list(supp=0.015,conf=0.5))
inspect(rules)
#-------------------------------------------------------------
#supp = 0.01
rules = apriori(tr,parameter = list(supp=0.01,conf=0.5))
inspect(rules)
#-------------------------------------------------------------
#supp = 0.009
rules = apriori(tr,parameter = list(supp=0.005,conf=0.5))
inspect(rules)

inspect(sort(rules,by='lift')[1:15])
itemsets=unique(generatingItemsets(rules))
itemsets
inspect(itemsets)


#
help(apriori)
maxrules = apriori(tr,list(supp=0.02,conf=0.5, target="maximally frequent itemsets"))
inspect(sort(maxrules))

