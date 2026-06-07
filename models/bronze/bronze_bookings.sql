{{
  config(
    materialized = "incremental",
    schema= 'bronze',
    )
}}




SELECT * FROM {{ source('staging', 'bookings') }}
{% if is_incremental() %}

  WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1901-01-01') FROM {{ this }})

{% endif %}