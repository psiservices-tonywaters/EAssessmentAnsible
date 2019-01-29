{{ item['name'] }}

{% for active_service in active_services %}
    active service: {{ active_service['name'] }}
{% endfor %}