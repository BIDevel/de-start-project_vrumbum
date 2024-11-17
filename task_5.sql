/*добавьте сюда запрос для решения задания 5*/
SELECT dc.brand_origin,
	   ROUND(MAX(s.price / (100 - discount) * 100 /*- s.price * ( discount / 100.00 )*/),2) price_max,
	   ROUND(MIN(s.price / (100 - discount) * 100/*- s.price * ( discount / 100.00 )*/),2) price_min
FROM car_shop.dm_sales s
 INNER JOIN car_shop.dm_cars dc ON dc.id = s.id_cars
GROUP BY dc.brand_origin;