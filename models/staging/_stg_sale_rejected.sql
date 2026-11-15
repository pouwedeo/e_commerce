{{
    config(
        MATERIALIZED = 'incremental',
        UNIQUE_KEY   = 'rejection_id'
    )
}}

select {{dbt_utils.generate_surrogate_key(['rn','sale_id', 'dt_sale', 'customer_id'])}} as rejection_id,
      sale_id, dt_sale, customer_id, convert_timezone('Europe/Paris', current_timestamp()) as rejected_at, 
        case
            when rn > 1 then 'Deduplicated data'
            when customer_id is null then 'Missing customer_id'  
            when dt_sale is null then 'Missing dt_sale'
            when sale_id is null then 'Missing sale_id'
        end as rejected_reason
from {{ref('_stg_sale_deduplicated')}}
where rn >1 or customer_id is null
             or dt_sale is null
             or sale_id is null