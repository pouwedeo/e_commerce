with distinct_category as (
   select distinct code_region, region_name from {{('stg_file_zone_geographique')}}
),
deduplicate_region as (
   select code_region, region_name,row_number() over (partition by code_region order by region_name) as rn

   from distinct_category
)
select row_number() over (order by code_region) as id_dim_region, code_region as cd_region, region_name, 1 as id_dim_contry
from deduplicate_region
where rn = 1