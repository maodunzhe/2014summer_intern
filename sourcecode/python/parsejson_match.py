## parse the json file with matched data into a file with three key features: latitude, longitude, match_status
import json

for i in range(24):
	data = []
	count = 0
	with open('/Users/chen.liang/Desktop/project/July 7 Match Logs/hour=' + '{:02}'.format(i) + '/tagstream_20140707' + '{:02}'.format(i) + '.log.t1.beacon.aws-ue1a.shazamcloud.com') as f:
		for line in f:
			data.append(json.loads(line))
			count += 1
		f.close()
	with open('/Users/chen.liang/Desktop/project/July 7 Match Logs/hour=' + '{:02}'.format(i) + '/tagstream_20140707' + '{:02}'.format(i) + '.log.t1.beacon.aws-ue1b.shazamcloud.com') as f:
		for line in f:
			data.append(json.loads(line))
			count += 1
		f.close()
	fo = open('hour' + str(i) + '.txt', 'w')

	for j in range(count):
		if 'geolocation' in data[j]['bean']['data']:
			fo.write(str(data[j]['bean']['data']['geolocation']['latitude']) + '\t')
			fo.write(str(data[j]['bean']['data']['geolocation']['longitude']) + '\t' + 'y' + '\n')
	fo.close()


