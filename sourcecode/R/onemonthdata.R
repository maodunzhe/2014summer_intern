##### data for a month #####
## read the data from a excel file and filter the data by rec_rate less than 0.4 and the number of tags bigger than 100
setwd('/Users/chen.liang/Desktop/output')
require(gdata)
df = read.xls("month.xlsx", sheet = 1, header = FALSE)
colnames(df) = c("ID", "success", "fail", "total", "rec_rate", "name", "type")
baddata = df[df$total > 100 & df$rec_rate < 0.4,]
baddata$name = as.character(baddata$name)
baddata$type = as.character(baddata$type)

## the part below is filling in the blank with the information got from google map manully
baddata[3,6] = 'sound nightclub'
baddata[21,6] = 'audio night club'
baddata[23,6] = 'sf mix'
baddata[14,6] = 'kentro greek kitchen'
baddata[25,6] = 'bank owned condos and lofts'
baddata[26,6] = 'urban mo\' bar and grill'
baddata[27,6] = 'sports bar'
baddata = baddata[with(baddata, order(rec_rate)),]
baddata[2, 7] = "entertainment center"
baddata[7, 7] = "bar"
baddata[9,7] = "entertainment"
baddata[11, 7] = "bar"
baddata[15, 7] = "amphitheater"
baddata[17, 7] = "apartment"
baddata[18,7] = "bar"
baddata[19,7] = "bar"
baddata[20, 7] = "bar"
baddata[23, 7] = "theatre"
baddata[25, 7] = "bar"
baddata[26, 7] = "airport"
baddata[27, 7] = "mall"

## list the name, total number of tags, rec_rate and types in the badchart
badchart = baddata[,c(6,4,5,7)]
row.names(badchart) = NULL

## the similar process as the bad chart
gooddata = df[df$total > 150 & df$rec_rate >0.85,]
gooddata$name = as.character(gooddata$name)
gooddata[1,6] = 'Fashion Valley mall'
gooddata[1,7] = 'shopping'
gooddata[4,6] = 'residential'
gooddata[5,6] = 'residential'
gooddata[7,6] = 'Glendale Fashion Center'
gooddata[9,6] = 'residential'
gooddata = gooddata[with(gooddata, order(rec_rate, decreasing = TRUE)),]
gooddata$type = as.character(gooddata$type)
gooddata[2, 7] = "hosue"
gooddata[2, 7] = "house"
gooddata[9,7] = "mall"
# goodchart
goodchart = gooddata[,c(6,4,5,7)]
row.names(goodchart) = NULL
setwd("/Users/chen.liang/Desktop/month/Final")
month_type = read.table('part-r-00000',sep = '\t',quote = "\"",col.names = c('type','success','fail','total','rec_rate'))

## manully group the types given by shapefile into 20 types listed below
month_type = month_type[month_type$total > 50,]
R = month_type
types = c('stadium','factory','bar','hotel','theatre','townhall','gym','shopping','convention','attraction','transportation','restaurant','school','church','residential','building','parking','hospital','bank','gas')
#stadium 13  40 70
r1 = apply(R[c(13,40,70),c(2,3,4)],2,sum)
#factory 18  36  63
r2 = apply(R[c(18,36,63),c(2,3,4)],2,sum)
#bar 2 4 19  50   55 59
r3 = apply(R[c(2,4,19,50,55,59),c(2,3,4)],2,sum)
#hotel 15 17 25
r4 = apply(R[c(15,17,25),c(2,3,4)],2,sum)
#theatre  21  42
r5 = apply(R[c(21,42),c(2,3,4)],2,sum)
#townhall  48 61
r6 = apply(R[c(48,61),c(2,3,4)],2,sum)
#gym 3 73
r7 = apply(R[c(3,73),c(2,3,4)],2,sum)
#shopping 10 12 31 47 69
r8 = apply(R[c(10,12,31,47,69),c(2,3,4)],2,sum)
#convention 76 77 78
r9 = apply(R[c(76,77,78),c(2,3,4)],2,sum)
#attraction  58 66 26
r10 = apply(R[c(58,66,26),c(2,3,4)],2,sum)
#transportation  41  24 49 72 74
r11 = apply(R[c(41,24,49,72,74),c(2,3,4)],2,sum)
#restaurant 8  52  62 64
r12 = apply(R[c(8,52,62,64),c(2,3,4)],2,sum)
#school 32 34  38 65
r13 = apply(R[c(32,34,38,65),c(2,3,4)],2,sum)
#church   20 79
r14 = apply(R[c(20,79),c(2,3,4)],2,sum)
#residential 27 33  57  51 68
r15 = apply(R[c(27,33,57,51,68),c(2,3,4)],2,sum)
#building  11 16 30  44  60  75
r16 = apply(R[c(11,16,30,44,60,75),c(2,3,4)],2,sum)
#parking  39 
r17 = apply(R[c(39),c(2,3,4)],2,sum)
#hospital  22  35  46
r18 = apply(R[c(22,35,46),c(2,3,4)],2,sum)
#bank 7
r19 = apply(R[c(7),c(2,3,4)],2,sum)
#gas 9  23  37  45
r20 = apply(R[c(9,23,37,45),c(2,3,4)],2,sum)
frame = data.frame(rbind(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20))
rownames(frame) = types
rec_rate = frame$success/frame$total
frame = cbind(frame,rec_rate)

