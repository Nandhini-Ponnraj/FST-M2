--Load CSV data into Pig
salesInput = LOAD 'hdfs:///user/nandhini/sales.csv' USING PigStorage(',') AS(Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data by Country
grpd = GROUP salesInput BY Country;
-- Count the number of rows
totalCount = FOREACH grpd GENERATE CONCAT((chararray)$0, CONCAT(':',(chararray)COUNT($1)));

--Remove old output
rmf hdfs:///user/nandhini/PigOutput2;
-- Store the output in the HDFS
STORE totalCount INTO 'hdfs:///user/nandhini/PigOutput2';
