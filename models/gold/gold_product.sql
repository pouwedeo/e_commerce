select p.dim_product,p.lib_product,p.price_product,p.current_value,p.valid_from,p.valid_to, c.lib_category, c.cd_category,sc.cd_subcategory, sc.lib_subcategory, 
from {{ref('dim_product')}} p
    inner join {{ref('dim_subcategory')}} sc 
    on p.id_dim_subcategory = sc.id_dim_subcategory
    inner join {{ref('dim_category')}} c 
    on sc.id_dim_category = c.id_dim_category
