## read.table from string may lead to factor: stringsAsFactors=FALSE /as.numeric(as.character)
## or just read the data correctly at first through the colClasses

LA = read.table('~/Desktop/data/LA/LA_AUGUST.txt',colClasses = c('numeric','numeric','character'))
colnames(LA) = c('latitude','longitude','status')
# Hollywood Bowl
LA_subset = subset(LA, latitude > 34.1112359356 & latitude < 34.1130120907 & longitude > -118.3403328808 & longitude < -118.3381488905)
rec_rate = nrow(subset(LA_subset,status == 'y'))/nrow(LA_subset)
# verizon wireless
# -117.75177598,33.636412888,-117.7485734224,33.6388290867
VERIZON = subset(LA, latitude >33.636412888 & latitude < 33.6388290867 & longitude > -117.75177598 & longitude < -117.7485734224)
rec_rate_Verizon = nrow(subset(VERIZON,status == 'y'))/nrow(VERIZON)
# Staples
## -118.2682246589,34.0421617396,-118.2653121216,34.0439617805
Staples = subset(LA, latitude > 34.0421617396 & latitude < 34.0439617805 & longitude > -118.2682246589 & longitude < -118.2653121216 )
rec_rate_Staples = nrow(subset(Staples, status == 'y'))/nrow(Staples)
# Nokia Theatre
# -118.2678920649,34.043904188,-118.2659558517,34.0449574661
Nokia = subset(LA, latitude > 34.043904188 & latitude < 34.0449574661 & longitude > -118.2678920649 & longitude < -118.2659558517)
rec_rate_Nokia = nrow(subset(Nokia, status == 'y'))/nrow(Nokia)
## conga room
#-118.2656819247,34.0444109157,-118.2643143398,34.0450997056
conga = subset(LA, latitude > 34.0444109157 & latitude < 34.0450997056 & longitude > -118.2656819247 & longitude < -118.2643143398)
rec_rate_conga = nrow(subset(conga, status == 'y'))/nrow(conga)

## function to calculate the rec_rate for differney places given the latitude and longitude border for the area
## jared park
# -118.2875205,34.0165309,-118.2846933,34.0181405
set <- function(lo1, la1, lo2, la2){
  return(subset(LA, latitude > la1 & latitude < la2 & longitude > lo1 & longitude < lo2))
}
jared = set(-118.2875205,34.0165309,-118.2846933,34.0181405)
rec_rate <- function(place){
  return(nrow(subset(place, status == 'y'))/nrow(place))
}
rec_rate_jared = rec_rate(jared)
coliseum = set(-118.2899351593,34.0127839357,-118.2855998376,34.0153735033)
rec_rate_coliseum = rec_rate(coliseum)
museum = set(-118.2899780746,34.0164122724,-118.2874881127,34.0179702586)
rec_rate_museum = rec_rate(museum)
science = set(-118.2875855442,34.0149894113,-118.2850955823,34.0165473975)
large = set(-118.2900960918,34.011094157,-118.2827674249,34.0180858651)
arena = set(-118.2861693378,34.011094157,-118.2827674249,34.0140040112)
rec_rate(arena)
full = set(-118.2905252453,34.0135486607,-118.2841085294,34.0183349127)
why = set(-118.2901175495,34.0154251195,-118.2872198918,34.0165207684)
theater = set(-118.2972300426,34.1191617926,-118.2953994357,34.1200929168)
rec_rate(theater)
EI = set(-118.3491495252,34.0623679744,-118.3486506343,34.0629990252)
rec_rate(EI)
ee = set(-118.3493131399,34.0623768625,-118.3482831717,34.0630012472)



## bayarea part

BAY = read.table('~/Desktop/data/BAY/bay_august.txt',colClasses = c('numeric','numeric','character'))
colnames(BAY) = c('latitude','longitude','status')
setBAY <- function(lo1, la1, lo2, la2){
  return(subset(BAY, latitude > la1 & latitude < la2 & longitude > lo1 & longitude < lo2))
}
sap = setBAY(-121.9023442268,37.332119191,-121.9001448154,37.3335779536)

rec_rate(sap)
innovation = setBAY(-121.890681982,37.3310293659,-121.889654696,37.3318206103)
park = setBAY(-121.8902689219,37.3316627887,-121.8888956308,37.3326097137)


## San Francisco part

SF = read.table('~/Desktop/data/SF/sf.txt', colClasses = c('numeric', 'numeric', 'character'))
colnames(SF) = c('latitude', 'longitude', 'status')
setBAY <- function(lo1, la1, lo2, la2){
  return(subset(SF, latitude > la1 & latitude < la2 & longitude > lo1 & longitude < lo2))
}
bar = setBAY(-122.4145013094,37.7598500311,-122.4137341976,37.7601893123)
rec_rate(bar)