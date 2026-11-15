with clean_product as(
     select nullif(trim(cd_product), '') as cd_product,
            nullif(trim(regexp_replace(initcap(lib_product), '\\s+')), '') as lib_product,
            nullif(trim(price_product), '') as price_product,
            nullif(trim(cd_subcategory), '') as cd_subcategory
    from {{source('bronze', 'PRODUCT')}}
)
select *, row_number() over (partition by cd_product order by lib_product) as rn
from clean_product