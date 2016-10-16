CREATE TABLE temp_tab_cmp (key int ,col1 array <string>,col2 map <int,string>,col3 struct <c1:smallint,c2:varchar(30)>)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '&' 
MAP KEYS TERMINATED BY '#';

--Data
1,array_value1&array_value2&array_value3,101#map_value_1&102#map_value_2,11&struct_value_1
2,array_value4&array_value5,103#map_value_3&104#map_value_4&105#map_value_5,12&struct_value_2


LOAD DATA LOCAL INPATH '/users/hdpqdi/compdata.csv' into table temp_tab_cmp;

hive> select * from temp_tab_cmp;
OK
1       ["array_value1","array_value2","array_value3"]  {101:"map_value_1",102:"map_value_2"}   {"c1":11,"c2":"struct_value_1"}
2       ["array_value4","array_value5"] {103:"map_value_3",104:"map_value_4",105:"map_value_5"} {"c1":12,"c2":"struct_value_2"}
Time taken: 0.104 seconds, Fetched: 2 row(s)

select key, array_value from temp_tab_cmp
LATERAL VIEW explode(col1) explode_alias AS array_value;

1       array_value1
1       array_value2
1       array_value3
2       array_value4
2       array_value5