## calculate the recognition rate for certain area given the latitude and longitude border of the area
attach(data)
rec_rate<-function(lo1,la1,lo2,la2){
  match = nrow(data[latitude > la1 & latitude < la2 & longitude > lo1 & longitude < lo2, ])
  unmatch = nrow(unmatch_data[unmatch_data$latitude > la1 & unmatch_data$latitude < la2 & unmatch_data$longitude > lo1 & unmatch_data$longitude < lo2,])
  rec = match/(match+unmatch)
  returnlist = list(rec,match+unmatch)
  return(returnlist)
} 


## NY -74.25909,40.477399,-73.700172,40.917577
# NY_rec = 0.7008267  number = 133421

## LA -118.6682,33.7036,-118.1553,34.3373
# LA_rec = 0.769194   nubmer = 100513

## chicago -87.940101,41.643919,-87.523984,42.023022
# CH_rec = 0.7560217   number = 44340

## HO -95.9097,29.5371,-95.0121,30.1104
# HO_rec = 0.7744415    number = 56083

## PH -75.280303,39.867005,-74.955831,40.137959
# PH_rec = 0.7592593  number = 18306

## PO -112.324056,33.29026,-111.92606,33.92057   
# PO_rec = 0.8018643   number = 20168

## Sa_An -98.811705,29.224141,-98.222958,29.731068
# Sa_An_rec = 0.8032501   number = 24601

## SD -117.3098,32.5348,-116.9082,33.1142
# SD_rec = 0.7687524   number = 28303

## DA -96.956899,32.616196,-96.636899,32.936196
# DA_rec = 0.7927732   number = 16079

## SJ -122.045672,37.124503,-121.589153,37.469217
# SJ_rec = 0.7694067    number = 15742

## AU -97.938383,30.098659,-97.561489,30.516863
# AU_rec = 0.7986774  number = 16029

## SF -123.173825,37.63983,-122.28178,37.929844
# SF_rec = 0.7466468   number = 15433

## SE -122.459696,47.481968,-122.224433,47.734139
# SE_rec = 0.7451147    number = 7062

## BO -71.19126,42.227654,-70.804488,42.396977
# BO_rec = 0.7336826    number = 11261

## LV -115.414628,36.048542,-115.027734,36.380491
# LV_rec = 0.7563793   number = 23200

## Miami -80.346539,25.709052,-80.139157,25.87679
# MI_rec = 0.7441478     number = 16404

####################################################################
#country level:

 Japan : 0.5877445   number = 125968
 Italy: 0.6243113     number = 932530
 France: 0.6826466    number = 1305283
 USA: 0.7902557      number = 2741605
 China : 0.573182   number = 194153
 Germany: 0.6906828   number = 575406
 Spain: 0.6778765    number = 553710
 UK: 0.7055166    number = 395934
 CA: 0.7836609    number = 139665
 RU: 0.5927876    number = 99911
 ME: 0.7314131    number = 681016
 AU: 0.7533835   number = 223436

