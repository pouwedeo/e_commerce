select cd_type_customer, lib_type_customer
from {{ref('_stg_type_customer_deduplicated')}}
where rn =1 and cd_type_customer is not null and lib_type_customer is not null