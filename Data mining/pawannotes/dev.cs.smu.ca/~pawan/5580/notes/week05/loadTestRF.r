# Usage:  Rscript loadTestRF testD resultsTest trainedRF.rda
args=commandArgs()

xyt=read.csv(file=args[6])
cols=ncol(xyt)
xt=data.frame(xyt[,1:(cols-1)])
yt=xyt[,cols]

library(randomForest)

# Load the model
load(args[8])

rftp=predict(rf,xt)
#Write the results
write.csv(cbind(yt,rftp),file=args[7],row.names=F)

