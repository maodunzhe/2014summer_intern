raw_data = LOAD '/Users/chen.liang/Downloads/KMEANS!/grouped/part-r-00000' as (center:chararray, points: bag{tag: tuple(status: chararray, latitude: double, longitude: double, point: chararray)});
centroided = foreach raw_data{
	match = filter points by status == '"y"';
	unmatch = filter points by status == '"n"';
	generate center, (float)(COUNT(match))/(float)(COUNT(match) + COUNT(unmatch)),(long)(COUNT(match) + COUNT(unmatch)) ;
}
store centroided into 'Final';


