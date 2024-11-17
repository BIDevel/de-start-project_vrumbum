/*добавьте сюда запрос для решения задания 2*/
SELECT 
	 mm.mark,
	 EXTRACT(YEAR FROM s.date) YYYY,
	 ROUND(AVG(s.price /*- s.price * ( discount / 100.00 )*/),2) avg_mark
FROM car_shop.dm_sales s
INNER JOIN car_shop.dm_cars dc ON dc.id = s.id_cars
 INNER JOIN car_shop.dic_marks_models mm ON mm.id = dc.id_mark_model
GROUP BY mm.mark,EXTRACT(YEAR FROM s.date)
ORDER BY mm.mark,EXTRACT(YEAR FROM s.date);