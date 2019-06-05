betterKmeans <- function(data,k,iter)
{
	ans = kmeans(data,k,iter)
	for(i in 1:10)
	{
		temp= kmeans(data,k,iter)
		if(temp$tot.withinss < ans$tot.withinss)
		{
			ans = temp
		}
	}
	ans
}
		
rightK <- function(data,lo,hi, iter)
{
   err=array((hi-lo+1)*2,dim=c((hi-lo+1),2))
   for(i in lo:hi)
   {
       rowNum=i-lo+1
       err[rowNum,1]=i
       err[rowNum,2]=betterKmeans(data,i,iter)$tot.withinss
   }
   err
}

