// group the output given by the script "rec_rate_for_each_venues.pig" by types and calculate the rec_rate for each type given by shapefiles
data = load 'part-r-00000' as (ID: long, success: long, fail: long, total: long, rate: double, name: chararray, type: chararray);
fulldata = filter data by type is not null;
newdata = FILTER fulldata by type != 'NULL';
data_group = GROUP newdata by type;
final = foreach data_group  generate group, SUM(newdata.success), SUM(newdata.fail),SUM(newdata.total),(double)SUM(newdata.success)/(double)SUM(newdata.total);
STORE final INTO 'typs_rec_rate.txt' using PigStorage();
