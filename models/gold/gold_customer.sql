with geo_information as (
select p.id_dim_postal_code, p.cd_postal, p.postal_commune_name,
        d.cd_department, d.department_name, 
        r.cd_region, r.region_name,
        ct.cd_country, ct.lib_country
from {{ref('dim_postal')}} p
    inner join {{ref('dim_departement')}} d
        on p.id_dim_department = d.id_dim_department
    inner join {{ref('dim_region')}} r
        on d.id_dim_region = r.id_dim_region
    inner join {{ref('dim_country')}} ct
        on r.id_dim_contry = ct.id_dim_country

)
select id_dim_customer, customer_id, first_name, last_name, valid_from, valid_to,               current_version,
        tc.dim_cd_type_customer, tc.lib_type_customer,
        g.cd_postal, g.postal_commune_name,
        g.cd_department, g.department_name, 
        g.cd_region, g.region_name,
        g.cd_country, g.lib_country
 from {{ref('dim_customer')}} c
    inner join {{ref('dim_type_customer')}} tc
        on c.dim_cd_type_customer = tc.dim_cd_type_customer    
    inner join geo_information g
        on c.id_dim_postal_code = g.id_dim_postal_code