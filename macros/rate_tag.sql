{% macro rate_tag(col) %}

    CASE 

        WHEN {{col}} > 95 THEN 'VERY GOOD'
        WHEN {{col}} > 80 THEN 'GOOD'
        WHEN {{col}} > 60 THEN 'FAIR'
        ELSE 'POOR'
    
    END

  
{% endmacro %}