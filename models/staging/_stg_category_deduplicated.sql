with cleaned_category as ( 
select nullif(trim(cd_category), '') as cd_category,
       nullif(trim(regexp_replace(initcap(lib_category), '\\s+', '')), '') as lib_category
       from {{source('bronze', 'CATEGORY')}}
)
select *, row_number() over(partition by lib_category order by cd_category) as rn
from cleaned_category