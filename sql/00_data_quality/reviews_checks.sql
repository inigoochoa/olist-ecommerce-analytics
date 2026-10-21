--Analizamos la clave primaria (review_id + order_id)
select
  count(*) as n_rows,
  count(distinct review_id) as n_review_ids,
  count(distinct order_id) as n_order_ids,
  count(distinct review_id || "-" || order_id) as n_rev_ord_id
from `olist-inigoochoa.olist_raw.reviews`;

--Analizamos cuántos registros hay por cada review_id con más de 1 order_id
select
  review_id,
  count(distinct order_id)
from `olist-inigoochoa.olist_raw.reviews`
group by 1
having count(distinct order_id) > 1
order by 2 desc;
--Aparecen 789 review_ids asociados a más de un order_id

--Revisamos algunos de los registros
select *
from `olist-inigoochoa.olist_raw.reviews`
where review_id = "ef5a41c50217f8e2b9296db3ba78f11e";

select *
from `olist-inigoochoa.olist_raw.reviews`
where review_id = "dbdf1ea31790c8ecfcc6750525661a9b";
--Efectivamente son reseñas duplicadas: mismo review_id pero distinto order_id

--Analizamos review_score
select
distinct review_score,
count(*) as n_reviews
from `olist-inigoochoa.olist_raw.reviews`
group by 1;

--Revisamos nulos
select
  countif(review_comment_title is null) as null_title,
  countif(review_comment_message is null) as null_message,
  countif(review_creation_date is null) as null_date,
  countif(review_answer_timestamp is null) as null_answer
from `olist-inigoochoa.olist_raw.reviews`
--Muchos nulos en título y mensaje, pero ninguno en date o answer.

