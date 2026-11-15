with cleaned_customer as (
select nullif(trim(regexp_replace(customer_id,'\\s+', '')), '') as customer_id,
    nullif(trim(last_name), '') as last_name,
    nullif(trim(first_name), '') as first_name,
    nullif(trim(address), '') as address,
    nullif(trim(postal_code), '') as postal_code,
    nullif(trim(country), '') as country,
    nullif(trim(city), '') as city,
    nullif(trim(cd_type_customer), '') as cd_type_customer,
 from {{source('bronze', 'CUSTOMER')}})
select *, row_number() over (partition by customer_id order by customer_id) as rn
from cleaned_customer