--Comprobamos si seller_id es la clave
select
  count(*) as n_rows,
  count(distinct seller_id) as seller_id_unique
from
  `olist-inigoochoa.olist_raw.sellers`;

--Comprobamos nulos
select
  countif(seller_id is null) as seller_id_null,
  countif(seller_zip_code_prefix is null) as seller_zip_null,
  countif(seller_city is null) as seller_city_null,
  countif(seller_state is null) as seller_state_null
from
  `olist-inigoochoa.olist_raw.sellers`;


--Analizamos el nº de ciudades y estados
select
  count(distinct lower(trim(seller_city))) as n_seller_city_clean,
  count(distinct lower(trim(seller_state))) as n_seller_state_clean
from
  `olist-inigoochoa.olist_raw.sellers`;

--Vemos que hay problemas de inconsistencia, especialmente con Sao Paulo
select
  distinct lower(trim(seller_city)) as seller_city
from
  `olist-inigoochoa.olist_raw.sellers`;


--Analizamos los estados
select
  distinct upper(trim(seller_state)) as n_seller_state_clean
from
  `olist-inigoochoa.olist_raw.sellers`;
--En esta ocasión no hay problemas de consistencia
