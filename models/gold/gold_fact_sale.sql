select 
        sale_id,
        id_dim_calendar,
        id_dim_customer,
        dim_product,
        quantity_sold,
        sale_price,
        sale_count
from {{ref('fact_sale')}}