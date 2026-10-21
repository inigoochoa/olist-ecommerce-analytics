--Comprobamos si order_id es la clave primaria
select
  count(*) as n_rows,
  count(distinct order_id) as n_order_id
from
  `olist-inigoochoa.olist_raw.order_payments`;

--Vemos si la combinación order_id + payment_sequential identifica a cada fila
select
  count(*) as n_rows,
  count(distinct (order_id || "_" || payment_sequential)) as n_order_seq_id
from
 `olist-inigoochoa.olist_raw.order_payments`;

--Comprobamos que un mismo order_id aparece varias vaeces:
select
  order_id,
  count(*) as n
from
  `olist-inigoochoa.olist_raw.order_payments`
group by 1
order by 2 desc;

--Comprobamos nulos:
select
  countif(order_id is null) as o_id_null,
  countif(payment_sequential is null) as p_seq_null,
  countif(payment_type is null) as p_type_null,
  countif(payment_installments is null) as p_inst_null,
  countif(payment_value is null) as p_val_null
from
 `olist-inigoochoa.olist_raw.order_payments`;


--Analizamos casos extraños
select
  *
from
 `olist-inigoochoa.olist_raw.order_payments`
where payment_value <= 0;

select
  *
from
 `olist-inigoochoa.olist_raw.order_payments`
where payment_installments <= 0;

select
*
from 
 `olist-inigoochoa.olist_raw.order_payments`

where order_id = "fa65dad1b0e818e3ccc5cb0e39231352"
order by payment_sequential;


--Vemos los distintos payment_type
select
distinct payment_type
from  `olist-inigoochoa.olist_raw.order_payments`;


