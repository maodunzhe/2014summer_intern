## the code does the kmeans clustering analysis as an example for the BAY AREA.
## 'K' is the number of clusters
total = read.table('./data/BAY/bay_august.txt',col.names = c('latitude', 'longitude', 'match_status'), colClasses = c('numeric', 'numeric', 'character'))
geo_data = total[,-3]
K <- 1500
set.seed(1)
CL <- kmeans(geo_data, K, iter.max = 50)

## plot the clustering result which is optinoal
plot(geo_data$latitude,geo_data$longitude,main='one_day',xlab='latitude',ylab='longitude',col=CL$cluster,pch=16,cex=0.5)

## calculate the recognition rate for each cluster, sort the list in ascending order and the oupput the clusters with rec_rate less than 0.6 which is an optionlal parameter
Rate = rep(0,K)
Cluster = CL$cluster
for (i in 1:K){
  B = total[Cluster == i,]
  Rate[i] = nrow(B[B$match_status == 'y',])/nrow(B)
}
New_data = data.frame(cbind(CL$centers,Rate, CL$size))
colnames(New_data)[c(3,4)] <- c('rate','size')
Sorted = New_data[order(New_data$rate),]
Sorted = subset(Sorted, rate < 0.6)

## the bad_center function below calculate the center of unmatched data in the cluster
bad_center<-function(row){
  temp = total[CL$cluster==row,]
  temp = subset(temp,match_status == 'n')
  temp = as.matrix(temp[,-3])
  return(apply(temp,2,mean))
}
rowname = row.names(Sorted)
for (i in 1: nrow(Sorted)){
  Sorted[i,c(1,2)] = bad_center(as.numeric(rowname[i]))
}
write.table(Sorted, file = "Bayarea.txt", sep = '\t', row.names = FALSE)
