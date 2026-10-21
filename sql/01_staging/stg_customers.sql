create or replace table `olist-inigoochoa.olist_staging.stg_customers` as

select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    lower(trim(customer_city)) as customer_city,
    upper(trim(customer_state)) as customer_state

from `olist-inigoochoa.olist_raw.customers`;