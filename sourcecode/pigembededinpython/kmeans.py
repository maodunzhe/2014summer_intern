#!/usr/bin/python
import sys
from math import fabs
from math import sqrt
from org.apache.pig.scripting import Pig
import random
import glob


## as for this part i can use pig embedded in python to make it faster
## as for the initialized cluster we should pay attention to the decimals and maybe there will be nonetype error with lots of clusters
## we can also change the value of tolerance
k = 5    ###### change the value of K
tolerance = 0
MAX_ITERATION = 100
# data = []
# path = '*.txt'
# files = glob.glob(path)
# for file in files:
# 	f = open(file, 'r')
# 	for line in f:
# 		read_data = line.split("\t")
# 		data.append((float(read_data[0]),float(read_data[1])))
# 	f.close()
# last_centroids = random.sample(set(data), k)

# initial centroid, equally divide the space

last_centroids = [(37.475097, -122.155599),(37.486098, -122.195388),(37.4985769, -122.2195727),(37.4608874, -122.143838),(37.453407, -122.182255)]
initial_centroids = ""
for i in range(k):
     initial_centroids = initial_centroids + str(last_centroids[i])
     if i!=k-1:
         initial_centroids = initial_centroids + ":"
#initial_centroids = "37.475097, -122.155599:37.486098,-122.195388:37.4985769, -122.2195727:37.4608874, -122.143838:37.453407, -122.182255"

# initial_centroids = "-120.0,-120.0:-60.0,-60.0:0.0, 0.0:60.0,60.0:120.0,120.0"
# last_centroids = [(-120.0,-120.0),(-60.0, -60.0),(0.0, 0.0),(60.0, 60.0),(120.0,120.0)]
print last_centroids
print initial_centroids



P = Pig.compile("""register Find.jar
                   DEFINE find_centroid FindCentroid('$centroids');
                   raw_data = load 'MP_match.txt' as (latitude:double, longitude:double, status:chararray);
                   centroided = foreach raw_data generate status, latitude, longitude, find_centroid(latitude, longitude) as centroid;
                   grouped = group centroided by centroid;
                   store grouped into 'grouped';
                   result = foreach grouped generate group, AVG(centroided.latitude), AVG(centroided.longitude);
                   store result into 'output';
                """)

converged = False
iter_num = 0
while iter_num < MAX_ITERATION:
	Q = P.bind({'centroids':initial_centroids})
	results = Q.runSingle()
	if results.isSuccessful() == "FAILED":
		raise "Pig job failed"
	iter = results.result("result").iterator()
	centroids = []
	x = 0.0
	y = 0.0
	distance_move = 0
	# get new centroid of this iteration, caculate the moving distance with last iteration
	initial_centroids = ""
	for i in range(k):
		tuple = iter.next()
		x = float(str(tuple.get(1)))
		y = float(str(tuple.get(2)))
		x_move = (last_centroids[i][0] - x)**2
		y_move = (last_centroids[i][1] - y)**2
		distance_move = distance_move + sqrt(x_move + y_move)
		print distance_move
	
		new_centroid = (x,y)
		centroids.append(new_centroid)
	
		initial_centroids = initial_centroids + str(x) + "," + str(y)
	
		if i!=k-1:
			initial_centroids = initial_centroids + ":"

	iter_num = iter_num + 1

	distance_move = distance_move / k;
	if distance_move>tolerance:
		Pig.fs("rmr grouped")
		Pig.fs("rmr output")
	print("iteration " + str(iter_num))
	print("average distance moved: " + str(distance_move))
	if distance_move<=tolerance:
		sys.stdout.write("k-means converged at centroids: [")
		sys.stdout.write(",".join(str(v) for v in centroids))
		sys.stdout.write("]\n")
		converged = True
		break


	last_centroids = centroids

	print last_centroids
	print initial_centroids
