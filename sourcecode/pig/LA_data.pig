REGISTER s3://data-engineering-interns/chen/lib/elephant-bird-2.1.11.jar;
REGISTER s3://data-engineering-interns/chen/lib/json-simple-1.1.1.jar;
REGISTER s3://data-engineering-interns/chen/lib/datameer-guava-11.0.1.jar;

SET default_parallel 60;

raw_data = LOAD 's3://data-engineering-team-bucket/beacon_logs/year=2014/month=8/*/*/*' using com.twitter.elephantbird.pig.load.JsonLoader() as (json: map[]);


A = FOREACH raw_data  {
	GENERATE (chararray)json#'data-type' as type,(chararray)json#'data-location' as location, (chararray)json#'country' as country, (chararray)json#'data-trackid' as trackid;
}

B = FILTER A BY  type == 'tagged' AND location IS NOT NULL AND location != '' AND country == 'US';


C = FOREACH B GENERATE trackid, FLATTEN(STRSPLIT(location, ',', 4));

D = FILTER C BY $1 != '0.0' AND $2 != '0.0' AND ($4 IS NULL OR (double)$4 < 2) AND (double)$2 > -118.6984 AND (double)$2 < -117.3368 AND (double)$1 > 33.5389 AND (double)$1 < 34.3373;

E = FOREACH D GENERATE $1, $2, ($0 is null ? 'n' : 'y');
/*
match = FILTER D by $0 is not NULL;

unmatch = FILTER D by $0 is NULL;

FINAL = FOREACH match GENERATE $1, $2, 'y';

FINAL1 = FOREACH unmatch GENERATE $1, $2, 'n';

FINAL2 = union FINAL, FINAL1;
*/

STORE E into 's3://data-engineering-interns/chen/output/myoutput_LA';
