create or replace table `olist-inigoochoa.olist_analytics.dim_products` as
  select
    p.product_id,
    p.product_category_name,
    t.product_category_name_en,
    p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
  from `olist-inigoochoa.olist_staging.stg_products` as p
  left join `olist-inigoochoa.olist_staging.stg_product_category_translation` as t
  on p.product_category_name = t.product_category_name_pt;