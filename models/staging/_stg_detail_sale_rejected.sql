{{
    config(
        MATERIALIZED = 'incremantal',
        UNIQUE_KEY   =  'rejection_key'
    )
}}

select {{dbt_utils.generate_surrogate_key(['sale_id', 'cd_product', 'quantity_sold', 'sale_price'])}} as rejection_key,
     sale_id, cd_product, quantity_sold, sale_price, convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
       case 
          when rn > 1 then 'Deduplicated data'
          when cd_product is null then 'Missing cd_product'
          when sale_id is null then 'Missing sale_id'
          when quantity_sold <= 0 then 'Invalid quantity_sold' 
          when sale_price <= 0 then 'Invalid sale_price'
       end as rejected_reason
from {{ref('_stg_detail_sale_deduplicated')}}
where rn >1 or quantity_sold <=0
             or sale_price <= 0
             or cd_product is null
             or sale_id is null