select customer_id, last_name, first_name, address, postal_code, city, country, cd_type_customer
from  {{ref('_stg_customer_deduplicated')}}
where rn = 1 and customer_id is not null
             and last_name is not null
             and first_name is not null
             and postal_code is not null
             and cd_type_customer is not null