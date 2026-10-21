-- Analizamos el nº de customer_id y de customer_unique_id
select
  count(*) as n_rows,
  count(distinct customer_id) as unique_customer_id,
  count(distinct customer_unique_id) as unique_customer_unique_id
from `olist-inigoochoa.olist_raw.customers`;

--Vemos que cada línea corresponde a un customer_id, pero que hay menos clientes reales: un único cliente puede tener varios customer_id
select
customer_unique_id,
count(customer_id)
from `olist-inigoochoa.olist_raw.customers`
group by 1
order by 2 desc
limit 10;

-- Revisamos nulos
select
  countif(customer_id is null) as null_customer_id,
  countif(customer_unique_id is null) as null_customer_unique_id,
  countif(customer_zip_code_prefix is null) as null_zip,
  countif(customer_city is null) as null_city,
  countif(customer_state is null) as null_state
from `olist-inigoochoa.olist_raw.customers`;

--Revisamos si un mismo customer_unique_id puede tener distintas direcciones

select
  customer_unique_id,
  count(distinct customer_zip_code_prefix) as n_zip,
  count(distinct customer_city) as n_cities,
  count(distinct customer_state) as n_states
from `olist-inigoochoa.olist_raw.customers`
group by customer_unique_id
having 
  count(distinct customer_zip_code_prefix) > 1
or count(distinct customer_city) > 1
or count(distinct customer_state) > 1
order by 2 desc,3 desc,4 desc;

-- Un mismo cliente puede tener distintas direcciones

-- Conclusiones:
--1. customer_id es la clave principal
--2. customer_unique_id representa los clientes reales, y permitirá detectar recurrencia
--3. Cada cliente puede hacer pedidos desde varias localizaciones, por lo que el análisis geográfico deberá realizarse a nivel pedido y no a nivel cliente.