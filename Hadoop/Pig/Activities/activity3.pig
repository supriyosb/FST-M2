
-- Load the CSV file
salesTable = LOAD 'hdfs:///user/supriyo/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- remove the old output
rmf hdfs:///user/supriyo/Pigoutput2
-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/supriyo/Pigoutput2' USING PigStorage('\t');
