yubikey-ksm:
  pkg.installed:
    - require:
      - pkg: epel

create-db-schema:
  cmd.run:
    - name: |
        mysql -u root -e 'create database ykksm' &&
        mysql -u root ykksm < /usr/share/doc/yubikey-ksm-1.5/ykksm-db.sql
    - unless: mysql -u root -e 'show databases' | grep ykksm
    - require:
      - pkg: yubikey-ksm
      - service: mysqld

create-db-users:
  file.managed:
    - name: /tmp/ykksm-users.sql
    - source: salt://yubikey/files/ykksm-users.sql
    - user: root
    - group: root
    - mode: 400
  cmd.run:
    - name: |
        mysql -u root ykksm < /tmp/ykksm-users.sql
    - unless: mysql -u root -e 'select user from mysql.user' | grep ykksmreader
    - require:
      - file: /tmp/ykksm-users.sql

symlink-decrypt-php:
  file.symlink:
    - name: /var/www/html/yubikey/wsapi/decrypt.php
    - target: /usr/share/ykksm/ykksm-decrypt.php
    - makedirs: True
    - require:
      - pkg: yubikey-ksm

symlink-utils-php:
  file.symlink:
    - name: /var/www/html/yubikey/wsapi/utils.php
    - target: /usr/share/ykksm/ykksm-utils.php
    - makedirs: True
    - require:
      - pkg: yubikey-ksm

ykksm-config:
  file.managed:
    - name: /etc/ykksm/ykksm-config.php
    - source: salt://yubikey/files/ykksm-config.php
    - user: root
    - group: apache
    - mode: 640

ykksm-httpd-config:
  file.managed:
    - name: /etc/httpd/conf.d/yubikey.conf
    - source: salt://yubikey/files/yubikey.conf
    - require:
      - pkg: httpd
    - watch_in:
      - service: httpd
 
ykksm-php-config:
  file.managed:
    - name: /etc/php.d/ykksm.ini
    - source: salt://yubikey/files/ykksm.ini
    - require:
      - pkg: httpd
      - pkg: yubikey-ksm
    - watch_in:
      - service: httpd
 