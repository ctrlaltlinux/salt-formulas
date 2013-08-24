{% set saltcloud = salt['pillar.get']('salt:cloud') %}

python-pip:
  pkg.installed

salt-cloud:
  pip.installed:
  - require:
    - pkg: python-pip

apache-libcloud:
  pip.installed:
  - require:
    - pkg: python-pip

/etc/salt/cloud.providers:
  file.managed:
    - source: salt://salt/files/cloud.providers
    - user: root
    - group: root
    - mode: 660
    - template: jinja
    - defaults:
      master: {{ salt['pillar.get']('id', 'salt') }}
      username: {{ saltcloud.username }}
      tenant: {{ saltcloud.tenant }}
      apikey: {{ saltcloud.apikey }}
      region: {{ saltcloud.region }}
