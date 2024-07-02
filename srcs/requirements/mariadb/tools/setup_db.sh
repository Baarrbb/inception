#!/bin/sh

mysqld &

sleep 2

echo "CREATE DATABASE $DB_NAME;" | mysql
echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" | mysql
echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' WITH GRANT OPTION;" | mysql
echo "GRANT ALL ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" | mysql
echo "FLUSH PRIVILEGES;" | mysql

mysqladmin shutdown

mysqld_safe
