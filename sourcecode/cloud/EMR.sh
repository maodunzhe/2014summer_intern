~/Documents/elastic-mapreduce-cli/elastic-mapreduce --create --alive \
--pig-script s3://data-engineering-interns/chen/script/rec_rate_speed.pig \
--instance-group master --instance-type m1.xlarge --instance-count 1 --bid-price 0.20 \
--instance-group core --instance-type m2.4xlarge --instance-count 10 --bid-price 0.20 \
--pig-versions 0.11.1.1 \
--ami-version 2.2.4 \
--log-uri s3://data-engineering-interns/chen/emrlog/ \
--enable-debugging
