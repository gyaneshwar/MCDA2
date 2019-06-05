#Usage: Rscript createTrainTestSet.r trainD.csv testD.csv

x=data.frame(array(runif(300,0.3,0.8),dim=c(100,3)))
xt=data.frame(array(runif(150,0.3,0.8),dim=c(50,3)))
y=4.5*x[,1]^2+9.8*x[,2]*x[,3]+99.45*x[,3]^3+runif(1,1:34)
yt=4.5*xt[,1]^2+9.8*xt[,2]*xt[,3]+99.45*xt[,3]^3+runif(1,1:34)
xy=data.frame(cbind(x,y))
xyt=data.frame(cbind(xt,yt))

args=commandArgs()

write.csv(xy,file=args[6],row.names=F)
write.csv(xyt,file=args[7],row.names=F)
