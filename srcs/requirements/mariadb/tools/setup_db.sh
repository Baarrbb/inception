#!/bin/sh

mysqld &

sleep 2

echo "CREATE DATABASE $MYSQL_DATABASE;" | mysql
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql
echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY 'WPpassw0rd' WITH GRANT OPTION;" | mysql
echo "GRANT ALL ON $MYSQL_DATABASE.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" | mysql
echo "FLUSH PRIVILEGES;" | mysql

mysqladmin shutdown

mysqld_safe
