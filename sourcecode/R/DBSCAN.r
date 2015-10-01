## try the DBSCAN method in an area in SF, the method runs very slow anyway

SF_large = subset(SF, latitude > 37.78 & latitude < 37.783 & longitude > -122.41 & longitude < -122.405)
SF_m = SF_large[,-3]
time1 = proc.time()

## 0.0003 and 40 are the two parameters in the dbscan, showplot = 2 means to plot the all process of the clustering method
d_m = dbscan(SF_m, 0.0003, 40, method = 'hybrid',showplot = 2)
table(d_m$cluster)

# the cluster 0 contains points that not belong to any groups so we let the count to be the length of the table - 1
count_m = length(table(d_m$cluster)) - 1
rec_m = matrix(0,count_m,4)
for(i in 1:count_m){
  cluster = SF_large[d_m$cluster == i,]
  rec_m[i,1] = nrow(cluster[cluster$status == 'y',])/nrow(cluster)
  rec_m[i,2] = nrow(cluster)
  rec_m[i,c(3,4)] = apply(as.matrix(cluster[,-3]),2, mean )
}
rec_m = data.frame(rec_m)
colnames(rec_m) = c('rec_rate', 'size', 'latitude', 'longitude')

## sort the result with size bigger than 50 and in ascending order
filtered_m = subset(rec_m, size > 50)
sorted_m = filtered_m[with(filtered_m, order(rec_rate)),]
time = proc.time() - time1

##check place:
rownames_m = as.numeric(row.names(sorted_m))

## find the worst cluster: rownames_m[1] and write the points in it into a CVS file
bad_place_m = SF_m[d_m$cluster == (rownames_m[1]),]
bad_center_m = sorted_m[1,c(3,4)]
setwd('~/Desktop/')
write.table(bad_place_m, file = "bad_m.txt", sep = '\t', row.names = FALSE)