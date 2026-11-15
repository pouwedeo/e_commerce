with clean_detail_sale as (
     select nullif(trim(sale_id), '') as sale_id, 
            nullif(trim(cd_product), '') as cd_product, 
            nullif(trim(quantity_sold), '')::integer as quantity_sold,
            nullif(replace(regexp_replace(trim(sale_price),'\\s+', '')
            ,',', '.'), '')::numeric(16,4) as sale_price
     from {{source('bronze','DETAIL_SALE')}}
)
select *, row_number() over (partition by sale_id, cd_product order by sale_price, cd_product) as rn
from clean_detail_sale