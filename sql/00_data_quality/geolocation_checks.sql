select
  count(*) as n_rows,
  count(distinct geolocation_zip_code_prefix) as unique_zip,
  count(distinct geolocation_lat || "-" || geolocation_lng) as unique_lat_long
from `olist-inigoochoa.olist_raw.geolocation`;


--Duplicados
with n_rows_dupl as (
  select 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state,
  count(*) as n_duplicated
  from `olist-inigoochoa.olist_raw.geolocation`
  group by 1,2,3,4,5
  having count(*) > 1
)
select 
  sum(n_duplicated - 1)
from n_rows_dupl;


WITH geolocation_dedup AS (
  SELECT DISTINCT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
  FROM `olist-inigoochoa.olist_raw.geolocation`
)

SELECT
  geolocation_zip_code_prefix,
  COUNT(*) AS n_rows
FROM geolocation_dedup
GROUP BY 1
ORDER BY 2 DESC;

--Analizamos la distribución de zip_code
select
  geolocation_zip_code_prefix,
  count(*) as n_rows

from `olist-inigoochoa.olist_raw.geolocation`
group by 1
order by 2 desc;

--Cuántas ciudades y estados hay por cada zip_code?
select
  geolocation_zip_code_prefix,
  count(distinct geolocation_city)
from `olist-inigoochoa.olist_raw.geolocation`
group by 1
order by 2 desc;

WITH states_per_zip AS (
  SELECT
    geolocation_zip_code_prefix,
    COUNT(DISTINCT geolocation_state) AS n_states
  FROM `olist-inigoochoa.olist_raw.geolocation`
  GROUP BY 1
)

SELECT
  g.geolocation_zip_code_prefix,
  g.geolocation_state,
  COUNT(*) AS n_rows
FROM `olist-inigoochoa.olist_raw.geolocation` g
JOIN states_per_zip s
  ON g.geolocation_zip_code_prefix = s.geolocation_zip_code_prefix
WHERE s.n_states > 1
GROUP BY 1, 2
ORDER BY 1, 3 DESC;






