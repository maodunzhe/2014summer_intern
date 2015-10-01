## open the ouput of google places api and count the numbers for each types shown in the file
typemap = {}
f = open('/Users/chen.liang/Desktop/kmeansoutput/google/London100.txt','r')
for line in f:
	result = line.split('\t')
	for i in range(2,len(result)-1,2):
		typelist = result[i].strip('[]').split(',')
		if typelist[0].strip() not in typemap:
			typemap[typelist[0].strip()] = 1
		else:
			typemap[typelist[0].strip()] += 1

## sort the dictionary in descending order in regard to numbers of types
fo = open('/Users/chen.liang/Desktop/kmeansoutput/types/type_London100.csv','w')
for w in sorted(typemap, key = typemap.get, reverse = True):
	fo.write(str(w) + '\t' + str(typemap[w]) + '\n')
fo.close()

