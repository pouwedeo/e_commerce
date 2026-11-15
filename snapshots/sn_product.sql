{% snapshot sn_product %}
{{
    config(
        target_schema = 'silver',
        unique_key = 'cd_product',
        strategy = 'check',
        check_cols = ['cd_product', 'lib_product', 'price_product', 'cd_subcategory']
    )
}}

select cd_product, lib_product, price_product, cd_subcategory
from {{ref('stg_product')}}

{% endsnapshot %}