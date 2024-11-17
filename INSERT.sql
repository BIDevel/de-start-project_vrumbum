/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/

TRUNCATE TABLE car_shop.dic_marks_models RESTART IDENTITY;
INSERT INTO car_shop.dic_marks_models(mark,model)
SELECT DISTINCT mark,model FROM raw_data.auto;

TRUNCATE TABLE car_shop.dm_cars RESTART IDENTITY;
-- CTE
WITH map_autos AS (
INSERT INTO car_shop.dm_cars(id_mark_model,color,gasoline_consumption,brand_origin)
SELECT mm.id id_mark_model, a.color, a.gasoline_consumption,a.brand_origin  FROM raw_data.auto a
 INNER JOIN car_shop.dic_marks_models mm ON a.mark = mm.mark AND a.model = mm.model
RETURNING id, id_mark_model, color
)
UPDATE raw_data.auto AS a
SET id_cars = ma.id
FROM map_autos AS ma
 INNER JOIN car_shop.dic_marks_models AS c ON ma.id_mark_model = c.id
WHERE a.auto = concat_ws(', ',concat_ws(' ',c.mark,c.model),ma.color);
SELECT * FROM car_shop.dm_cars;


TRUNCATE TABLE car_shop.dic_clients RESTART IDENTITY;
INSERT INTO car_shop.dic_clients(name,phone)
SELECT DISTINCT person_name,phone FROM raw_data.sales; 

TRUNCATE TABLE car_shop.dm_sales RESTART IDENTITY;
INSERT INTO car_shop.dm_sales(id_cars,price,date,id_client,discount)
SELECT a.id_cars,s.price,s.date,c.id AS id_client, discount FROM raw_data.sales s
 INNER JOIN raw_data.auto a using (auto) 
 	INNER JOIN car_shop.dic_clients c ON s.person_name = c.name AND s.phone = c.phone;
 	
-- запрос ниже ничего не должен вернуть
SELECT auto,gasoline_consumption,price,date,person_name,phone,discount,brand_origin FROM raw_data.sales a 
EXCEPT
SELECT 
	concat_ws(', ',concat_ws(' ',mm.mark,mm.model),dc.color) auto,
	dc.gasoline_consumption,s.price,s.date,c.name AS person_name, c.phone,s.discount,dc.brand_origin
FROM car_shop.dm_sales s
 INNER JOIN car_shop.dic_clients c ON c.id = s.id_client
 INNER JOIN car_shop.dm_cars dc ON dc.id = s.id_cars
 INNER JOIN car_shop.dic_marks_models mm ON mm.id = dc.id_mark_model;
