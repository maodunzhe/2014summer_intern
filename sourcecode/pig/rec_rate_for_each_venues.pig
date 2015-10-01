// load the data given by SKY and group the data
A = load 'dataonemonth' as (trackID: long, venueID: long, venuename: chararray, venuetype: chararray, longitude: double, latitude: double, time: long, match: chararray) ;
B = FILTER A BY match == 'matched';
C = FILTER A BY match == 'unmatched';
newB = group B by (venueID, venuename, venuetype);
newC = group C by (venueID, venuename, venuetype);

// D and F are the relation of venueID, venuename, venuetype and the number of tags for matched and unmatched data respectively
D = foreach newB generate flatten(group), COUNT(B);
F = foreach newC generate flatten(group), COUNT(C);
G = JOIN D by $0 FULL, F by $0;

// Join the matched and unmatched data for each venue and then output the id, number of matched tags, number of unmatched tags, total number of tags, rec_rate, name and type of the venue 
H = foreach G generate ($0 is NULL ? $4 : $0), ($3 is NULL ? 0:$3), ($7 is NULL ? 0:$7), $1, $2;
Final = foreach H generate $0, $1, $2, $1 + $2, (float)$1 / (float)($1 + $2), $3, $4;
STORE Final INTO 'month' using PigStorage();