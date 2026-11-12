{{
    config(
        materialized = 'incremental',
        UNIQUE_KEY = 'rejection_id'
    )
}}

select {{dbt_utils.generate_surrogate_key(['rn', 'cd_category', 'lib_category'])}} as rejection_id,
cd_category, lib_category, convert_timezone('Europe/Paris', CURRENT_TIMESTAMP()) as rejected_at,
case
    when cd_category is null  then 'Missing code category'
    when lib_category is null then 'Missing libele category'
    when rn>1                 then 'duplicated category'
end as reject_reason
from {{ref('_stg_category_deduplicated')}}
where rn > 1 or lib_category is null or cd_category is null