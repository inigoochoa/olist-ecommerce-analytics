create or replace table `olist-inigoochoa.olist_staging.stg_geolocation` as

  select 
    distinct
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    lower(trim(geolocation_city)) as geolocation_city,
    upper(trim(geolocation_state)) as geolocation_state
  
  from `olist-inigoochoa.olist_raw.geolocation`