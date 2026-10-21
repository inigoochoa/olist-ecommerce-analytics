create or replace table `olist-inigoochoa.olist_analytics.dim_geolocation` as

with tabla_medianas as (
  select
    geolocation_zip_code_prefix,
    (approx_quantiles(geolocation_lat, 2))[offset(1)] as median_latitude,
    (approx_quantiles(geolocation_lng, 2))[offset(1)] as median_longitude
  from `olist-inigoochoa.olist_staging.stg_geolocation`
  group by 1
),
moda_ciudad_ranked as (
  select 
    geolocation_zip_code_prefix,
    geolocation_city,
    --count(*) as n_city,
    row_number() over(partition by geolocation_zip_code_prefix
                      order by count(*) DESC, geolocation_city asc) as rank_city
  
  from `olist-inigoochoa.olist_staging.stg_geolocation`
  group by 1,2
  
),
moda_ciudad_zip_code as (
  select
    geolocation_zip_code_prefix,
    geolocation_city
  from moda_ciudad_ranked
  where rank_city = 1
),
moda_estado_ranked as (
  select 
    geolocation_zip_code_prefix,
    geolocation_state,
    --count(*) as n_city,
    row_number() over(partition by geolocation_zip_code_prefix
                      order by count(*) DESC, geolocation_state asc) as rank_state
  
  from `olist-inigoochoa.olist_staging.stg_geolocation`
  group by 1,2
  
),
moda_estado_zip_code as (
  select
    geolocation_zip_code_prefix,
    geolocation_state
  from moda_estado_ranked
  where rank_state = 1

)

select
  m.geolocation_zip_code_prefix,
  m.median_latitude,
  m.median_longitude,
  c.geolocation_city,
  e.geolocation_state
from tabla_medianas m
left join moda_ciudad_zip_code c
on m.geolocation_zip_code_prefix = c.geolocation_zip_code_prefix
left join moda_estado_zip_code e
on m.geolocation_zip_code_prefix = e.geolocation_zip_code_prefix
order by m.geolocation_zip_code_prefix;