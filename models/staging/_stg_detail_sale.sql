select sale_id, cd_product, quantity_sold, sale_price
from {{ref('_stg_detail_sale_deduplicated')}}
where rn = 1 and sale_id is not null and cd_product is not null and quantity_sold > 0 and sale_price > 0