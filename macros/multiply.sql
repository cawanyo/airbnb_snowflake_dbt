{% macro multiply(col1, col2, decimals=2) %}
    ROUND({{ col1 }} * {{ col2 }}, {{ decimals }})
{% endmacro %}