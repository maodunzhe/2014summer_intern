### use python to parse the json file got from google places API
import urllib2
import json

## open the file and read the cluster centers in it and decode the json file into a list
## here the parameter in google places api we choose the radius as 200 meters and rankby prominence
## the key is created by me
filename = '4000_NY_new.txt'
data = []  ## list of the clusters' features
data_http = []  ## list of the decoded json files
f = open(filename,'r')
for line in f:
	line_split = line.split('\t')
	http = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + line_split[0] + ',' + line_split[1] + "&rankby=prominence&radius=200&key=AIzaSyA4P_kUygg0dkMqeplSNSEpYUCNZB7id14"
	data_http.append(json.loads(urllib2.urlopen(http).read()))
	data.append(line_split)

f.close()

## the types in the meaningless_type are larger or districtive area which we are not interested in, so we should filter them out
meaningless_type = ['administrative_area_level_1','administrative_area_level_2','administrative_area_level_3','administrative_area_level_4','administrative_area_level_5',
'colloquial_area','country','floor','geocode','intersection','locality','natural_feature','neighborhood','political',
'point_of_interest','post_box','postal_code','postal_code_prefix','postal_town','premise','room','route','street_address',
'street_number','sublocality','sublocality_level_1','sublocality_level_2','sublocality_level_3','sublocality_level_4',
'sublocality_level_5','subpremise','transit_station', 'park']

## list the top 3 places output by the google places api
fo = open('/Users/chen.liang/Desktop/kmeansoutput/google/NY100.txt','w')
for i in range(len(data)):
	fo.write(str(data[i]) + '\t')
	newlist = [item for item in data_http[i]['results'] if not set(meaningless_type)&set(item['types'])]
	for j in range(min(len(newlist),3)):
		fo.write(newlist[j]['name'].encode('utf8') + '\t' + str(newlist[j]['types']) + '\t')
	fo.write('\n')

fo.close()