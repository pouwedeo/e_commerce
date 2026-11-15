{{
    config(
        MATERIALIZED = 'incremental',
        UNIQUE_KEY   = 'rejected_id'
    )
}}

select {{dbt_utils.generate_surrogate_key(['customer_id', 'last_name', 'first_name', 'address', 'postal_code', 'city', 'cd_type_customer'])}} as rejected_id,
customer_id, last_name, first_name, address, postal_code, city, cd_type_customer,
convert_timezone('Europe/Paris', CURRENT_TIMESTAMP()) as rejected_at,
case 
    when customer_id is null then 'Missing customer ID'
    when last_name is null then 'Missing last name'
    when first_name is null then 'Missing first name'
    when address is null then 'Missing address'
    when postal_code is null then 'Missing postal code'
    when city is null then 'Missing city'
    when country is null then 'Missing country'
    when cd_type_customer is null then 'Missing cd_type_customer'
    when rn >1 then 'Deduplicated data'
end as rejected_reason
from  {{ref('_stg_customer_deduplicated')}}
where rn>1 or  customer_id is null or last_name is null 
           or first_name is null
           or postal_code is null
           or cd_type_customer is null