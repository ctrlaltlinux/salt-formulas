ntp:
  pkg:
    - installed

ntp.conf:
  file:
    - managed
    - name: /etc/ntp.conf
    - source: salt://ntp/files/ntp.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

ntpd:
  service:
    - running
    - watch:
      - file: ntp.conf
    - require:
      - pkg: ntp
