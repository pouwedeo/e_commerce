select row_number() over (order by cd_type_customer) as dim_cd_type_customer, cd_type_customer, lib_type_customer
from {{ref('stg_type_customer')}}