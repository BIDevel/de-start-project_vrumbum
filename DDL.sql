/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/

CREATE SCHEMA IF NOT EXISTS car_shop;

CREATE TABLE IF NOT EXISTS car_shop.dic_marks_models(
id serial PRIMARY KEY,
mark varchar(20) NOT NULL, -- уверен что не будет добавляться марки длинее 20 символов и текущие не обрежутся, обязательное поле
model varchar(30) NOT NULL -- уверен что не будет добавляться модели длинее 30 символов и текущие не обрежутся, обязательное поле
);

CREATE TABLE IF NOT EXISTS car_shop.dm_cars(
id serial PRIMARY KEY,
id_mark_model integer REFERENCES car_shop.dic_marks_models ON DELETE RESTRICT,
color varchar(20) NOT NULL, -- уверен что не будет цвета длинее 20 select length('серобурмалиновый') символов и текущие не обрежутся, обязательное поле
gasoline_consumption numeric(3,1), -- 99 литров на 100 километров макс, остальное не машина, ракета, не обязательное поле
brand_origin varchar(12) -- странно что есть пустые, из не откуда 12 ( South Korea +1)
);

CREATE TABLE car_shop.dic_clients(
id serial PRIMARY KEY,
name varchar(30) NOT NULL, -- 26 max, на будущее 30 ставлю, обязательное поле
phone varchar(25) NOT NULL -- 22 max, на будущее 25 ставлю, обязательное поле
);

CREATE TABLE car_shop.dm_sales(
id serial PRIMARY KEY,
id_cars integer REFERENCES car_shop.dm_cars,
price numeric(21,12),
date date,
id_client integer REFERENCES car_shop.dic_clients,
discount smallint NOT NULL DEFAULT 0
);
