
select 
 row_number() over(ORDER BY p.dbt_scd_id)   as dim_product,
 p.dbt_valid_from as valid_from,
 p.dbt_valid_to as valid_to,
 case when valid_to is null then 1 else 0 end as current_value,
 p.cd_product, p.lib_product, p.price_product, sc.id_dim_subcategory
from {{ref('sn_product')}} p
     left OUTER join {{ref('dim_subcategory')}} sc on p.cd_subcategory = sc.cd_subcategory
where sc.cd_subcategory is not NULL