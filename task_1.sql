/*добавьте сюда запрос для решения задания 1*/
SELECT 100.00 * SUM(ELECTRO)/SUM(TTL)  nulls_percentage_gasoline_consumption
FROM (
SELECT CASE WHEN gasoline_consumption IS NULL THEN 1 ELSE 0 END ELECTRO, 1 AS TTL
FROM car_shop.dm_cars
) a;
