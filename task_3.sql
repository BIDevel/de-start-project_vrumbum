/*добавьте сюда запрос для решения задания 3*/
SELECT 
	 EXTRACT(MONTH FROM s.date) "month",
	 EXTRACT(YEAR FROM s.date) "year",
	 ROUND(AVG(s.price /*- s.price * ( discount / 100.00 )*/),2) avg_mark
FROM car_shop.dm_sales s 
WHERE EXTRACT(YEAR FROM s.date) = 2022
GROUP BY EXTRACT(MONTH FROM s.date),EXTRACT(YEAR FROM s.date)
ORDER BY EXTRACT(MONTH FROM s.date),EXTRACT(YEAR FROM s.date);