REGISTER s3://data-engineering-interns/chen/lib/elephant-bird-2.1.11.jar;
REGISTER s3://data-engineering-interns/chen/lib/json-simple-1.1.1.jar;
REGISTER s3://data-engineering-interns/chen/lib/datameer-guava-11.0.1.jar;

raw_data = LOAD 's3://data-engineering-team-bucket/beacon_logs/year=2014/month=8/*/*/*' using com.twitter.elephantbird.pig.load.JsonLoader() as (json: map[]);


A = FOREACH raw_data  {
	GENERATE (chararray)json#'data-type' as type,(chararray)json#'data-location' as location, (chararray)json#'country' as country, (chararray)json#'data-trackid' as trackid;
}

B = FILTER A BY  type == 'tagged' AND location IS NOT NULL AND location != '' AND country == 'US';


C = FOREACH B GENERATE trackid, FLATTEN(STRSPLIT(location, ',', 4));

D = FILTER C BY $1 != '0.0' AND $2 != '0.0' AND ($4 IS NULL OR (double)$4 < 2) AND (double)$2 > -74.259088 AND (double)$2 < -73.700272 AND (double)$1 > 40.495996 AND (double)$1 < 40.915256;

match = FILTER D by $0 is not NULL;

unmatch = FILTER D by $0 is NULL;

FINAL = FOREACH match GENERATE $1, $2, 'y';

FINAL1 = FOREACH unmatch GENERATE $1, $2, 'n';

FINAL2 = union FINAL, FINAL1;

STORE FINAL2 into 's3://data-engineering-interns/chen/output/NY_August';