create or replace table `olist-inigoochoa.olist_staging.stg_product_category_translation` as
select
  lower(trim(string_field_0)) as product_category_name_pt,
  lower(trim(string_field_1)) as product_category_name_en
from
  `olist-inigoochoa.olist_raw.product_category_translation`;