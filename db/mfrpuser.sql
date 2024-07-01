create user if not exists 'mfrpuser'@'localhost' identified by '838814';
grant select, insert, update, delete on mfrp.* to 'mfrpuser'@'localhost';
flush privileges;

-- drop user 'mfrpuser@localhost';