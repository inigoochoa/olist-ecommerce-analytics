create or replace table `olist-inigoochoa.olist_staging.stg_reviews` as
select
  review_id,
  order_id,
  review_score,
  review_comment_title,
  review_comment_message,
  review_creation_date,
  review_answer_timestamp
from `olist-inigoochoa.olist_raw.reviews`;