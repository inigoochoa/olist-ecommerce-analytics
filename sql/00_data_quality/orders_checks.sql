--Confirmamos que order_id es clave primaria, comprobando que hay una fila por cada pedido
select 
  count(*) as n_rows,
  count(distinct order_id) as unique_orders
from
  `olist-inigoochoa.olist_raw.orders`;

--Comprobamos el estado de cada pedido
select
  order_status,
  count(*) as n_orders
from `olist-inigoochoa.olist_raw.orders`
group by order_status
order by n_orders DESC;

--Comprobamos nulos según el estado del pedido
select
  countif(order_purchase_timestamp is null) as null_purchase,
  countif(order_approved_at is null) as null_approved,
  countif(order_delivered_carrier_date is null) as null_carrier,
  countif(order_delivered_customer_date is null) as null_customer_delivery,
  countif(order_estimated_delivery_date is null) as null_estimated
from `olist-inigoochoa.olist_raw.orders`;


--Revisamos posibles inconsistencias en las fechas, ya que el orden lógico sería: order_purchase < order_approved < order_carrier < order_customer 
select *
from `olist-inigoochoa.olist_raw.orders`
where
  order_approved_at < order_purchase_timestamp
or order_delivered_carrier_date < order_approved_at
or order_delivered_customer_date < order_delivered_carrier_date;

--Calculamos nº total de pedidos con inconsistencias entre fechas: 1382 pedidos sobre un total de 99441 = 1.4%
select
  count(*) as orders_with_date_inconsistency
from `olist-inigoochoa.olist_raw.orders`
where
  order_delivered_carrier_date < order_approved_at
  or order_delivered_customer_date < order_delivered_carrier_date
  or order_delivered_carrier_date < order_purchase_timestamp
  or order_approved_at > order_delivered_customer_date;

--Clasificamos cada tipo de inconsistencia, donde vemos que la mayoría de casos son order_carrier < order_approval
select
  countif(
    order_approved_at < order_purchase_timestamp
  ) as approved_before_purchase,

  countif(
    order_delivered_carrier_date < order_approved_at
  ) as carrier_before_approval,

  countif(
    order_delivered_customer_date < order_delivered_carrier_date
  ) as customer_before_carrier,

  countif(
    order_delivered_customer_date < order_purchase_timestamp
  ) as delivered_before_purchase

from `olist-inigoochoa.olist_raw.orders`;


--Comprobamos la magnitud de la diferencia entre carrier y approval
select
  order_id,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_carrier_date,
  timestamp_diff(order_approved_at, order_delivered_carrier_date, HOUR) AS hours_carrier_before_approval
from `olist-inigoochoa.olist_raw.orders`
where order_delivered_carrier_date < order_approved_at
order by hours_carrier_before_approval DESC;

--También vemos que hay 166 pedidos donde carrier va antes de purchase
SELECT
  COUNT(*) AS carrier_before_purchase
FROM `olist-inigoochoa.olist_raw.orders`
WHERE order_delivered_carrier_date < order_purchase_timestamp;

--Y 61 pedidos donde approved va después de delivered
select
  count(*) as approved_after_customer_delivery
from `olist-inigoochoa.olist_raw.orders`
where order_delivered_customer_date < order_approved_at;

--Decisión:
    -- Mantener estos datos en staging
    -- Marcar los pedidos con inconsistencias para poder excluirlos de análisis posteriores donde las inconsistencias tengan efecto en el resultado 
