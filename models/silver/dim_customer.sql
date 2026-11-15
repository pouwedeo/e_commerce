select 
row_number() over(order by c.dbt_scd_id) as id_dim_customer,
c.dbt_valid_from as valid_from,
c.dbt_valid_to as valid_to,
case WHEN c.dbt_valid_to is null then 1 else 0 end as current_version,
c.customer_id, c.first_name, c.last_name, p.id_dim_postal_code, t.dim_cd_type_customer
from {{ref('sn_customer')}} c
     left outer JOIN {{ref('dim_postal')}} p on c.postal_code = p.cd_postal
     left outer JOIN {{ref('dim_type_customer')}} t on c.cd_type_customer = t.cd_type_customer
     WHERE c.postal_code is not null and c.cd_type_customer is not null