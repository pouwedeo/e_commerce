select row_number() over (order by code_commune_postal) as id_dim_postal_code, 
code_commune_postal as cd_postal, postal_commune_name, id_dim_department
from {{ref('stg_file_zone_geographique')}} zg 
inner join {{ref('dim_departement')}} d on zg.code_department = d.cd_department