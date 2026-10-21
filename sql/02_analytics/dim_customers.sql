create or replace table `olist-inigoochoa.olist_analytics.dim_customers` as
  select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
  from `olist-inigoochoa.olist_staging.stg_customers`;