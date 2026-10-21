create or replace table `olist-inigoochoa.olist_analytics.fact_order_items` as

select
  order_id,
  order_item_id,
  product_id,
  seller_id,
  price,
  freight_value,
  price + freight_value as item_total_value
from `olist-inigoochoa.olist_staging.stg_order_items`;