select 
c.customer_id, c.first_name, c.last_name, p.id_dim_postal_code, t.dim_cd_type_customer,
convert_timezone('Europe/Paris', CURRENT_TIMESTAMP()) as rejected_at,
CASE 
    WHEN c.postal_code is NULL THEN  'Missing postal_code'
    WHEN c.cd_type_customer is null then 'Missing cd_type_customer'
      
END as rejected_reason
from {{ref('sn_customer')}} c
     left outer JOIN {{ref('dim_postal')}} p on c.postal_code = p.cd_postal
     left outer JOIN {{ref('dim_type_customer')}} t on c.cd_type_customer = t.cd_type_customer
     WHERE c.postal_code is null and c.cd_type_customer is  null