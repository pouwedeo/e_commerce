{% snapshot sn_customer %}

{{

  config(
    target_schema = 'silver',
    unique_key = 'customer_id',
    strategy = 'check',
    check_cols=['customer_id', 'first_name', 'last_name','postal_code','cd_type_customer' ]

    )
}}


select customer_id, first_name, last_name, postal_code,cd_type_customer
from {{ref('stg_customer')}}
{% endsnapshot %}