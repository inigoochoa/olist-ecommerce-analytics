-- Comprobamos número de filas y pedidos y productos únicos
select
  count(*) as n_rows,
  count(distinct order_id) as unique_orders,
  count(distinct order_item_id) as unique_items
from `olist-inigoochoa.olist_raw.order_items`;

--Vemos si order_id + order_item_id puede ser la clave primaria
select
  count(*) as n_rows,
  count(distinct order_id || "_" || order_item_id)
from `olist-inigoochoa.olist_raw.order_items`;


select
  order_id,
  order_item_id,
  count(*) as n_rows
from `olist-inigoochoa.olist_raw.order_items`
group by
  order_id,
  order_item_id
having count(*) > 1
order by n_rows desc;

-- Analizamos los nulos
select
  countif(order_id is null) as null_order_id,
  countif(order_item_id is null) as null_order_item_id,
  countif(product_id is null) as null_product_id,
  countif(seller_id is null) as null_seller_id,
  countif(price is null) as null_price,
  countif(freight_value is null) as null_freight
from `olist-inigoochoa.olist_raw.order_items`;

-- Revisamos valores imposibles o sospechosos
select
  countif(price <= 0) as non_positive_price,
  countif(freight_value < 0) as negative_freight
from `olist-inigoochoa.olist_raw.order_items`;

-- Analizamos precios y envíos para ver posibles outliers o errores
select
  min(price) as min_price,
  max(price) as max_price,
  avg(price) as avg_price,
  min(freight_value) as min_freight,
  max(freight_value) as max_freight,
  avg(freight_value) as avg_freight
from `olist-inigoochoa.olist_raw.order_items`;

--Conclusiones:

--1. order_id + order_item_id es la clave primaria
--2. No hay duplicados ni nulos
--3. No hay precios iguales o menores que 0
--4. Para la tabla de staging, decido eliminar la columna shipping_limit_date