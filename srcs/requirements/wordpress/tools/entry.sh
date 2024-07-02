#!/bin/sh

path=/var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root --path=$path

# Genere le wp-config.php
cd $path
wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=$WP_HOST_DB

# CREATE ADMIN
wp core install --allow-root --path=$path --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL

# CREATE USER
wp user create --allow-root --path=$path $WP_USER $WP_EMAIL --user_pass=$WP_PASSWD --role=$WP_USER_ROLE

php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
