

{{ 

      config(
        materialized = 'incremental',
        unique_key = 'BOOKING_ID'
        )
}}
select
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2) }} + CLEANING_FEE + SERVICE_FEE AS TOTAL_AMOUNT,
    BOOKING_STATUS,
    CREATED_AT

from {{ ref('bronze_bookings') }}

{# {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
where event_time >= (select coalesce(max(event_time),'1900-01-01') from {{ this }} )

{% endif %} #}