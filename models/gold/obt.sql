{% set configs = [
    {
        "table": ref('silver_bookings'),
        "column": "silver_bookings.*",
        "alias": "silver_bookings"
    },
    {
        "table": ref('silver_listings'),
        "column": "silver_listings.PROPERTY_TYPE, silver_listings.ROOM_TYPE, silver_listings.CITY, silver_listings.COUNTRY, silver_listings.BEDROOMS , silver_listings.ACCOMMODATES, silver_listings.PRICE_PER_NIGHT, silver_listings.PRICE_PER_NIGHT_TAG, silver_listings.CREATED_AT as LISTING_CREATED_AT ",
        "alias": "silver_listings",
        "join_condition": "silver_bookings.listing_id = silver_listings.listing_id"
    },
    {
        "table": ref('silver_hosts'),
        "column": "silver_hosts.HOST_ID, silver_hosts.HOST_NAME, silver_hosts.HOST_SINCE, silver_hosts.IS_SUPERHOST, silver_hosts.RESPONSE_RATE, silver_hosts.RESPONSE_RATE_QUALITY, silver_hosts.CREATED_AT as HOST_CREATED_AT ",
        "alias": "silver_hosts",
        "join_condition": "silver_hosts.host_id = silver_listings.host_id"
    }
] %}



SELECT 
    {% for conf in configs %}
        {{ conf['column'] }}
        {% if not loop.last %}
        ,
        {% endif %}
    {% endfor %}

    FROM 
    {% for conf in configs %}
        {% if loop.first %}
            {{ conf['table'] }} AS {{conf['alias']}}

        {% else %}
            LEFT JOIN {{ conf['table']}} as {{ conf['alias']}}
            ON {{ conf['join_condition']}}
        {% endif %} 
    {% endfor%}