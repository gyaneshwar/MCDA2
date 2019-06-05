# Usage:  Rscript trainSaveRF.r trainD.csv resultsTrain.csv trainedRF.rda
args=commandArgs()

xy=read.csv(file=args[6])
cols=ncol(xy)
x=data.frame(xy[,1:(cols-1)])
y=xy[,cols]

library(randomForest)

rf=randomForest(x,y)
rfp=predict(rf,x)

#Write the results
write.csv(cbind(y,rfp),file=args[7],row.names=F)

#Save the model
save(rf,file=args[8])

