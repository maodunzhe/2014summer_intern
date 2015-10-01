### do similar things as "google_API.py" but this time sort the places by the distance to the center of clusters and limit the types of places as shown below see the google places API parameter online for details
import urllib2
import json

filename = '1000_SF_new.txt'
data = []
data_http = []
f = open(filename,'r')
for line in f:
	line_split = line.split('\t')
	http = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + line_split[0] + ',' + line_split[1] + "&rankby=distance&types=bar|restaurant|cafe|casino|gym|movie_theater|night_club|stadium|establishment&key=AIzaSyA4P_kUygg0dkMqeplSNSEpYUCNZB7id14" 
	data_http.append(json.loads(urllib2.urlopen(http).read()))
	data.append(line_split)

f.close()

fo = open('/Users/chen.liang/Desktop/kmeansoutput/google/SF_bad_nopark_100disrance.txt','w')
for i in range(len(data)):
	fo.write(str(data[i]) + '\t')
	for j in range(min(len(data_http[i]['results']),3)):
		fo.write(data_http[i]['results'][j]['name'].encode('utf8') + '\t' + str(data_http[i]['results'][j]['types']) + '\t')
	fo.write('\n')

fo.close()