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
rules = apriori(tr,parameter = list(supp=0.009,conf=0.5))
inspect(rules)
rules = apriori(tr,parameter = list(supp=0.3,conf=0.5))
inspect(rules)
rules = apriori(tr,parameter = list(supp=0.2,conf=0.5))
inspect(rules)
rules = apriori(tr,parameter = list(supp=0.02,conf=0.5))
inspect(rules)
inspect(sort(rules,by='lift')[1:15])
itemsets=unique(generatingItemsets(rules))
itemsets
inspect(itemsets)
