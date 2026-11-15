select cd_product, lib_product, price_product, cd_subcategory
from {{ref('_stg_product_deduplicated')}}
where rn =1 and cd_product is not null 
            and lib_product is not null
            and cd_subcategory is not null