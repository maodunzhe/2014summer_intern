// do the similar thing as the pig script "rec_rate_for_each_venues.pig" but this time  make the data with same trackID
// venueID, longitude, latitude and match status shown only once and the calculate the rec_rate again
A = load 'dataonemonth' as (trackID: long, venueID: long, venuename: chararray, venuetype: chararray, longitude: double, latitude: double, time: long, match: chararray) ;
F = group A by ($0, $1, $4, $5, $7);
filtered = foreach F {
	top = LIMIT A 1;
	generate FLATTEN(top);
};
B = FILTER filtered BY match == 'matched';
C = FILTER filtered BY match == 'unmatched';
newB = group B by (venueID, venuename, venuetype);
newC = group C by (venueID, venuename, venuetype);
D = foreach newB generate flatten(group), COUNT(B);
F = foreach newC generate flatten(group), COUNT(C);
G = JOIN D by $0 FULL, F by $0;
H = foreach G generate ($0 is NULL ? $4 : $0), ($3 is NULL ? 0:$3), ($7 is NULL ? 0:$7), $1, $2;
Final = foreach H generate $0, $1, $2, $1 + $2, (float)$1 / (float)($1 + $2), $3, $4;
STORE Final INTO 'monthdata’ using PigStorage();
