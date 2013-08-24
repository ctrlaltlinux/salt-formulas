base:
  '*':
    {%- for sls in salt['pillar.items']() %}
    - {{ sls }}
    {%- endfor %}
