{{
    config(
        MATERIALIZED = 'incremental',
        UNIQUE_KEY   = 'rejection_id'
    )
}}
select dbt_utils.generate_surrogate_key(['cd_product', 'lib_product', 'price_product', 'cd_subcategory']) as rejction_id,
     cd_product, lib_product, price_product, cd_subcategory,
       convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
       case
            when rn > 1 then 'Deduplicated data'
            when cd_product is null then 'Missing cd_product'            
            when lib_product is null then 'Missing lib_product'
            when price_product is null then 'Missing price_product'
            when cd_subcategory is null then 'Missing cd_subcategory'
        end as rejected_reason
from {{ref('_stg_product_deduplicated')}}
where  rn > 1  or cd_product is null 
            or lib_product is null
            or price_product is null
            or cd_subcategory is null
       