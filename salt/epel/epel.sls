{% set rpm = 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm' %}

epel:
  pkg:
    - installed
    - sources:
      - epel-release: {{ salt['pillar.get']('epel:rpm', rpm) }}
