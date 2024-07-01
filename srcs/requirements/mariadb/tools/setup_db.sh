#!/bin/sh

mysqld &

sleep 2

echo "CREATE DATABASE $MYSQL_DB;" | mysql
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWD';" | mysql
echo "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWD' WITH GRANT OPTION;" | mysql
echo "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_ADMIN'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWD' WITH GRANT OPTION;" | mysql
echo "FLUSH PRIVILEGES;" | mysql

mysqladmin shutdown

mysqld_safe

# bash
