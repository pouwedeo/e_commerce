
with clean_sale as(
     select nullif(trim(customer_id), '') as customer_id,
            nullif(trim(sale_id), '') as sale_id, 
            coalesce(
                try_to_date(replace(trim(dt_sale),'/','-'), 'YYYY-MM-DD'),
                try_to_date(replace(trim(dt_sale),'/','-'), 'DD-MM-YYYY'),
                try_to_date(replace(trim(dt_sale),'/','-'), 'MM-DD-YYYY')
            ) as dt_sale,

    from {{source('bronze', 'SALE')}}
)
select *, row_number() over (partition by sale_id order by dt_sale desc) as rn
from clean_sale