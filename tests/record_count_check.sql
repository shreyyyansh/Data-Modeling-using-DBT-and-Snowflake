{% set expected_counts = {
    'cust': 50,
    'ordr': 200,
    'ordritms': 1000
} %}

{% for table, expected_count in expected_counts.items() %}
SELECT '{{ table }}' AS table_name,
       (SELECT COUNT(*) FROM {{ source('landing', table) }}) AS record_count,
       {{ expected_count }} AS expected_count
WHERE (SELECT COUNT(*) FROM {{ source('landing', table) }}) < {{ expected_count }}
{% if not loop.last %} UNION ALL {% endif %}
{% endfor %}