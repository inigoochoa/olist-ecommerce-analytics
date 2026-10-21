create or replace table  `olist-inigoochoa.olist_staging.stg_order_payments` as

select
  order_id,
  payment_sequential,
  payment_type,
  payment_installments,
  payment_value
 from `olist-inigoochoa.olist_raw.order_payments`