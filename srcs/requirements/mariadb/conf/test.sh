#!/bin/sh
service mysql start 

# CREATE USER #
echo "CREATE USER 'wordpress_user'@'%' IDENTIFIED BY '1234';" | mysql

# PRIVILGES FOR ROOT AND USER FOR ALL IP ADRESS #
echo "GRANT ALL PRIVILEGES ON *.* TO 'wordpress_user'@'%' IDENTIFIED BY '1234';" | mysql
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '1234';" | mysql
echo "FLUSH PRIVILEGES;" | mysql

# CREAT WORDPRESS DATABASE #
echo "CREATE DATABASE wordpress_db;" | mysql

kill $(cat /var/run/mysqld/mysqld.pid)

# mysqld


# #!/bin/sh
# service mysql start 

# # CREATE USER #
# echo "CREATE USER '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql

# # PRIVILGES FOR ROOT AND USER FOR ALL IP ADRESS #
# echo "GRANT ALL PRIVILEGES ON *.* TO '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$BDD_ROOT_PASSWORD';" | mysql
# echo "FLUSH PRIVILEGES;" | mysql

# # CREAT WORDPRESS DATABASE #
# echo "CREATE DATABASE $BDD_NAME;" | mysql

# kill $(cat /var/run/mysqld/mysqld.pid)

# mysqld


