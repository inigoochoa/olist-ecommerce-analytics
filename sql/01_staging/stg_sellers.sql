create or replace table `olist-inigoochoa.olist_staging.stg_sellers` as 

select
  seller_id,
  seller_zip_code_prefix,
  lower(trim(seller_city)) as seller_city,
  upper(trim(seller_state)) as seller_state
from
  `olist-inigoochoa.olist_raw.sellers`;