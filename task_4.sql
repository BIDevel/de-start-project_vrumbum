/*добавьте сюда запрос для решения задания 4*/
SELECT 
	  c.name person,STRING_AGG(mm.mark||' '||mm.model,', ') cars
FROM car_shop.dm_sales s
INNER JOIN car_shop.dic_clients c ON c.id = s.id_client
 INNER JOIN car_shop.dm_cars dc ON dc.id = s.id_cars
 INNER JOIN car_shop.dic_marks_models mm ON mm.id = dc.id_mark_model
GROUP BY c.name ;