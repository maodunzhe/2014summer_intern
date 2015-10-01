// filter the data with speed bigger than 1 and focus on the rec_rate with speed on SF, NY, LA, BAYAREA, LONDON 5 cities
REGISTER s3://data-engineering-interns/chen/lib/elephant-bird-2.1.11.jar;
REGISTER s3://data-engineering-interns/chen/lib/json-simple-1.1.1.jar;
REGISTER s3://data-engineering-interns/chen/lib/datameer-guava-11.0.1.jar;

raw_data = LOAD 's3://data-engineering-team-bucket/beacon_logs/year=2014/month=8/*/*/*' using com.twitter.elephantbird.pig.load.JsonLoader() as (json: map[]);


A = FOREACH raw_data  {
	GENERATE (chararray)json#'data-type' as type,(chararray)json#'data-location' as location, (chararray)json#'country' as country, (chararray)json#'data-trackid' as trackid;
}

B = FILTER A BY  type == 'tagged' AND location IS NOT NULL AND location != '' AND country == 'US';


C = FOREACH B GENERATE trackid, FLATTEN(STRSPLIT(location, ',', 4));

D = FILTER C BY $1 != '0.0' AND $2 != '0.0' AND $4 IS NOT NULL AND (double)$4 > 1;

LA = FILTER D BY (double)$2 > -118.6984 AND (double)$2 < -117.3368 AND (double)$1 > 33.5389 AND (double)$1 < 34.3373;

London = FILTER D BY (double)$2 > -0.351468 AND (double)$2 < 0.148271 AND (double)$1 > 51.38494 AND (double)$1 < 51.672343;

NY = FILTER D BY (double)$2 > -74.259088 AND (double)$2 < -73.700272 AND (double)$1 > 40.495996 AND (double)$1 < 40.915256;

SF = FILTER D BY (double)$2 > -122.518631 AND (double)$2 < -122.378727 AND (double)$1 > 37.666163 AND (double)$1 < 37.813777;

BAY = FILTER D BY  (double)$2 > -122.279131 AND (double)$2 < -121.736096 AND (double)$1 > 37.218601 AND (double)$1 < 37.570835;

match_SF = FILTER SF by $0 is not NULL;

unmatch_SF = FILTER SF by $0 is NULL;

match_LA = FILTER LA by $0 is not NULL;

unmatch_LA = FILTER LA by $0 is NULL;

match_London = FILTER London by $0 is not NULL;

unmatch_London = FILTER London by $0 is NULL;

match_NY = FILTER NY by $0 is not NULL;

unmatch_NY = FILTER NY by $0 is NULL;

match_BAY = FILTER BAY by $0 is not NULL;

unmatch_BAY = FILTER BAY by $0 is NULL;

FINAL = UNION match_SF, unmatch_SF, match_LA, unmatch_LA, match_London, unmatch_London, match_NY, unmatch_NY, match_BAY, unmatch_BAY;

STORE FINAL into 's3://data-engineering-interns/chen/output/rec_rate_speed';

