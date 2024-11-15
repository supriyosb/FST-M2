--Load input file from HDFS
inputFile = LOAD 'hdfs:///user/supriyo/input.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
cntd = FOREACH grpd GENERATE $0 AS word, COUNT($1) AS no_of_words;
-- To remove old outputs
rmf hdfs:///user/supriyo/PigOutput1;
-- Store the result in HDFS
STORE cntd INTO 'hdfs:///user/supriyo/PigOutput1';
