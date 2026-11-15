select 
 p.cd_product, p.lib_product, p.price_product, 'rejection' as rejected_raison, 
 convert_timezone('Europe/Paris', CURRENT_TIMESTAMP()) as rejected_at
from {{ref('sn_product')}} p
     left OUTER join {{ref('dim_subcategory')}} sc on p.cd_subcategory = sc.cd_subcategory
where sc.cd_subcategory is  NULL