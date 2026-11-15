select row_number() over (order by cd_subcategory) as id_dim_subcategory, cd_subcategory, lib_subcategory, id_dim_category
from {{ref('stg_subcategory')}} cs
left outer join {{ref('dim_category')}} c on cs.cd_category = c.cd_category
where c.id_dim_category  is not null