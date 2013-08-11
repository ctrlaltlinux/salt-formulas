pam_yubico:
  pkg.installed:
    - require:
      - pkg: epel

/etc/sysconfig/yubikey:
  file.managed:
    - source: salt://yubikey/files/yubikey
    - user: root
    - group: root
    - mode: 400
    - template: jinja
    - require:
      - pkg: pam_yubico
 
/etc/pam.d/sshd:
  file.managed:
    - source: salt://yubikey/files/sshd
    - require:
      - pkg: pam_yubico
