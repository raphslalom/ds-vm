CREATE DATABASE IF NOT EXISTS examples;

USE examples;

CREATE EXTERNAL TABLE  IF NOT EXISTS gt_city
(dt DATE, AverageTemperature DECIMAL(4, 2), AverageTemperatureUncertainty DECIMAL(4, 3), City STRING, Country STRING, Latitude STRING, Longitude STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION "/user/vagrant/data/earth-surface-temperature/hive/GlobalLandTemperaturesByMajorCity" 
TBLPROPERTIES("skip.header.line.count"="1");

DESCRIBE gt_city;

SELECT * FROM gt_city LIMIT 10;