#!/bin/sh

DB_USER=$(cat /run/secrets/my_db_user)
DB_PASSWD=$(cat /run/secrets/my_db_passwd)
DB_ROOT_PASSWD=$(cat /run/secrets/my_db_root_passwd)

sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start

sleep 2

if mariadb -e "USE $DB_NAME;" 2> /dev/null; then 
	echo "Database already exists"
else
	mariadb -e "CREATE DATABASE $DB_NAME;"
	mariadb -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';"
	mariadb -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' WITH GRANT OPTION;"
	mariadb -e "GRANT ALL ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;"
	mariadb -e "FLUSH PRIVILEGES;"
	echo "Database created"
fi

service mariadb stop

sleep 2

exec mysqld_safe

# echo "CREATE DATABASE $DB_NAME;" | mariadb
# echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" | mariadb
# echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' WITH GRANT OPTION;" | mariadb
# echo "GRANT ALL ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" | mariadb
# echo "FLUSH PRIVILEGES;" | mariadb

# mariadb -e "CREATE DATABASE $DB_NAME;"
# mariadb -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';"
# mariadb -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' WITH GRANT OPTION;"
# mariadb -e "GRANT ALL ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;"
# mariadb -e "FLUSH PRIVILEGES;"
