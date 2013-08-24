{% set saltcloud = salt['pillar.get']('salt:cloud') %}

salt-cloud-required-pkgs:
  pkg.installed:
    - pkgs:
      - python-pip
      - sshpass

## The salt-cloud package from EPEL doesn't work with the version
## of salt-master from EPEL. We install it using pip instead.
salt-cloud:
  pip.installed:
  - require:
    - pkg: salt-cloud-required-pkgs

apache-libcloud:
  pip.installed:
  - require:
    - pkg: salt-cloud-required-pkgs

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

## Todo: Should pull profile information from pillar
/etc/salt/cloud.profiles:
  file.managed:
    - source: salt://salt/files/cloud.profiles
    - user: root
    - group: root
    - mode: 660
    - template: jinja
