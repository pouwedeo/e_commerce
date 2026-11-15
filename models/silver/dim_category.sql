select row_number() over (order by cd_category) as id_dim_category, cd_category, lib_category
from {{ref('stg_category')}}
