{{
    config(
        MATERIALIZED = 'incremental',
        UNIQUE_KEY   = 'rejection_id'
    )
}}
select {{dbt_utils.generate_surrogate_key(['cd_type_customer', 'lib_type_customer'])}} as rejection_id,
    cd_type_customer, lib_type_customer, convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    case
        when cd_type_customer is null then 'Missing cd_type_customer'
        when lib_type_customer is null then 'Missing lib_type_customer'
        when rn > 1 then 'Deduplicated data'
   end as rejected_reason
from {{ref('_stg_type_customer_deduplicated')}}
where rn >1  or cd_type_customer is null 
            or lib_type_customer is  null