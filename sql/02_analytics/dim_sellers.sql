create or replace table `olist-inigoochoa.olist_analytics.dim_sellers` as
  select
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
  from `olist-inigoochoa.olist_staging.stg_sellers`