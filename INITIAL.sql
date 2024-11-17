/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/
CREATE SCHEMA IF NOT EXISTS raw_data;

CREATE TABLE IF NOT EXISTS raw_data.sales(
id integer,
auto text,
gasoline_consumption NUMERIC(10,2) null,
price NUMERIC(21,12),
date date,
person_name text,
phone text,
discount smallint,
brand_origin text
);


\copy raw_data.sales(id,auto,gasoline_consumption,price,date,person_name,phone,discount,brand_origin) FROM 'c:\temp\cars.csv' WITH CSV HEADER NULL 'null';

CREATE TABLE IF NOT EXISTS raw_data.auto(
auto varchar(23),
mark varchar(23),
model varchar(23),
color varchar(23),
gasoline_consumption numeric(7,2),
brand_origin varchar(20),
id_cars integer
);

INSERT INTO raw_data.auto(auto,mark,model,color,gasoline_consumption,brand_origin)
SELECT DISTINCT auto,mark,TRIM(REPLACE(REPLACE(REPLACE(auto,mark,''),color,''),',',''),' ') model,color,gasoline_consumption,brand_origin 
FROM (
SELECT s.auto,SPLIT_PART(s.auto,' ',-1) color,SPLIT_PART(s.auto,' ',1) mark,gasoline_consumption,brand_origin 
FROM raw_data.sales s
CROSS JOIN GENERATE_SERIES(1,10,1) AS elements
GROUP BY s.id,SPLIT_PART(auto,' ',elements),s.auto,elements,s.gasoline_consumption,s.brand_origin
HAVING SPLIT_PART(s.auto,' ',elements) <> ''
) a;

