{% set default_servers = ['0.centos.pool.ntp.org',
                          '1.centos.pool.ntp.org',
                          '2.centos.pool.ntp.org'] %}

ntp:
  pkg.installed

ntpd:
  service.running:
    - watch:
      - file: ntp.conf
    - require:
      - pkg: ntp

ntp.conf:
  file.managed:
    - name: /etc/ntp.conf
    - source: salt://ntp/files/ntp.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      servers: {{ salt['pillar.get']('ntp:servers', default_servers) }}
