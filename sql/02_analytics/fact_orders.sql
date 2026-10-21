create or replace table `olist-inigoochoa.olist_analytics.fact_orders` as

with review_per_order_id as (
  select
    order_id,
    count(review_score) as n_reviews,
    avg(review_score) as avg_review_score
  from `olist-inigoochoa.olist_staging.stg_reviews`
  group by order_id
),
payment_by_order as (
  select
    order_id,
    sum(payment_value) as total_payment_value,
    count(*) as n_payment_components,
    count(distinct payment_type) as n_payment_types,
    max(payment_installments) as max_installments
  from `olist-inigoochoa.olist_staging.stg_order_payments`
  group by order_id
)
select
  o.order_id,
  o.customer_id,
  o.order_status,
  o.order_purchase_timestamp,
  o.order_approved_at,
  o.order_delivered_carrier_date,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,
  c.customer_unique_id,
  r.n_reviews,
  r.avg_review_score,
  timestamp_diff(o.order_approved_at, o.order_purchase_timestamp, HOUR) as purchase_to_approval_hours,
  case when o.order_delivered_carrier_date >= o.order_approved_at then timestamp_diff(o.order_delivered_carrier_date, o.order_approved_at, HOUR) end as approval_to_carrier_hours,
  case when o.order_delivered_customer_date >= o.order_delivered_carrier_date then timestamp_diff(o.order_delivered_customer_date, o.order_delivered_carrier_date, HOUR) end as carrier_to_customer_hours,
  case when o.order_delivered_customer_date >= o.order_purchase_timestamp then timestamp_diff(o.order_delivered_customer_date, o.order_purchase_timestamp, HOUR) end as purchase_to_customer_hours,
  date_diff(date(o.order_delivered_customer_date), date(o.order_estimated_delivery_date), DAY) as delivery_delay_days,
  coalesce(
    (
    o.order_approved_at < o.order_purchase_timestamp
    or o.order_delivered_carrier_date < o.order_approved_at
    or o.order_delivered_customer_date < o.order_delivered_carrier_date
    or o.order_delivered_carrier_date < o.order_purchase_timestamp
    or o.order_approved_at > o.order_delivered_customer_date
    ),
    false
) as has_date_inconsistency,
  DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date) as is_late_delivery,
  p.total_payment_value,
  p.n_payment_components,
  p.n_payment_types,
  p.max_installments

from
  `olist-inigoochoa.olist_staging.stg_orders` as o
left join `olist-inigoochoa.olist_staging.stg_customers` as c
on o.customer_id = c.customer_id
left join review_per_order_id as r
on o.order_id = r.order_id
left join payment_by_order as p
on o.order_id = p.order_id;
