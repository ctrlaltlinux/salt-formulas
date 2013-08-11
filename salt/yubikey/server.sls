include:
  - .ykval # Yubikey Validation Server
  - .ykksm # Yubikey Key Storage Module

mysql-server:
  pkg:
    - installed
  service:
    - running
    - name: mysqld
    - enabled: True
    - reload: True

php-mysql:
  pkg.installed

httpd:
  pkg:
    - installed
  service:
    - running
    - enabled: True
    - reload: True
