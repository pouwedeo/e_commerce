with distinct_department as (
   select distinct code_department, department_name, code_region from {{ref('stg_file_zone_geographique')}}
),
deduplicate_department as (
   select code_department, department_name,code_region, row_number() over (partition by code_department order by department_name) as rn

   from distinct_department
)
select row_number() over (order by code_department) as id_dim_department, code_department as cd_department, department_name,id_dim_region
from deduplicate_department d inner join {{ref('dim_region')}} r on d.code_region = r.cd_region
where rn = 1