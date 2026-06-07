{{ 

      config(
        materialized = 'incremental',
        unique_key = 'HOST_ID'
        )
}}


SELECT 

    HOST_ID, 
    REPLACE(HOST_NAME,' ', '_') AS HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE,
    CREATED_AT,
    {{ rate_tag('RESPONSE_RATE')}} AS RESPONSE_RATE_QUALITY




FROM {{ ref('bronze_hosts') }}