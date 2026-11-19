WITH sale_detail AS(
    select s.sale_id, s.dt_sale, s.customer_id, 
        d.cd_product, d.quantity_sold, d.sale_price
        from {{ref('stg_sale')}} s 
        inner join {{ref('_stg_detail_sale')}} d on s.sale_id = d.sale_id
), join_detail as (
    select sd.sale_id,
           sd.dt_sale,
           c.customer_id,
           p.cd_product,
           ca.id_dim_calendar,
           c.id_dim_customer,
           p.dim_product,
           sd.quantity_sold,
           sd.sale_price
    from sale_detail sd
          left outer join {{ref('dim_customer')}} c 
            on sd.customer_id = c.customer_id
            and (sd.dt_sale < c.valid_to or c.valid_to is null)
          left outer join {{ref('dim_product')}} p 
            on sd.cd_product = p.cd_product
            and (sd.dt_sale = p.valid_to or p.valid_to is null)
         left outer join {{ref('dim_calendar')}} ca 
            on sd.dt_sale = ca.dt_calendar 
         qualify row_number() over(
                               partition by sd.sale_id, sd.cd_product
                               order by c.valid_from desc, p.valid_from desc 
         ) = 1
      
)
select 
        sale_id,
        dt_sale,
        customer_id,
        cd_product,
        convert_timezone('Europe/Paris', CURRENT_TIMESTAMP()) as rejected_at,
        CASE 
            WHEN id_dim_customer is null THEN  'unmatched customer'
            when dim_product is null then 'unmatched product'
            WHEN id_dim_calendar is null THEN 'unmatched calendar date'
        END as rejected_reason
from join_detail
    where id_dim_calendar is  null
          or id_dim_customer is  NULL
          or dim_product is  null