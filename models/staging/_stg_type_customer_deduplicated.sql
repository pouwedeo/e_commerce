with clean_type_customer as (
       select nullif(trim(cd_type_customer), '') as cd_type_customer,
       nullif(trim(regexp_replace(initcap(lib_type_customer), '\\s+', '')), '') as lib_type_customer
       from {{source('bronze', 'TYPE_CUSTOMER')}}
) 
select *, row_number() over (partition by cd_type_customer order by lib_type_customer) as rn
from clean_type_customer
