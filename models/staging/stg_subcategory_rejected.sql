{{
    config(
        MATERIALIZED = 'incremental',
        UNIQUE_KEY   = 'rejection_id'
    )
}}

select  {{dbt_utils.generate_surrogate_key(['rn','cd_subcategory', 'lib_subcategory', 'cd_category'])}} as rejection_id,
cd_subcategory, lib_subcategory, cd_category, convert_timezone('Europe/Paris', CURRENT_TIMESTAMP()) as rejected_at,
case 
    when cd_subcategory is null then 'Missing code subcategory'
    when lib_subcategory is null then 'Missing subcategory name'
    when cd_category is null then 'Missing category code'
    when rn > 1               then 'Deduplicated key'
end as rejected_reason
from {{ref('_stg_subcategory_deduplicated')}}
where rn>1 or lib_subcategory is null 
           or cd_subcategory is null 
           or cd_category is null
  

