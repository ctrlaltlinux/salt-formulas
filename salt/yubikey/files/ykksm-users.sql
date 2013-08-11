create user 'ykksmreader';
grant select on ykksm.yubikeys to 'ykksmreader'@'localhost';
set password for 'ykksmreader'@'localhost' = password('secret');
create user 'ykksmimporter';
grant insert on ykksm.yubikeys to 'ykksmimporter'@'localhost';
set password for 'ykksmimporter'@'localhost' = password('secret');
flush privileges;
