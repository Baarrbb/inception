#!/bin/sh

DB_USER=$(cat /run/secrets/my_db_user)
DB_PASSWD=$(cat /run/secrets/my_db_passwd)
WP_ADMIN=$(cat /run/secrets/my_wp_admin)
WP_ADMIN_PASSWD=$(cat /run/secrets/my_wp_admin_passwd)
WP_USER=$(cat /run/secrets/my_wp_user)
WP_PASSWD=$(cat /run/secrets/my_wp_passwd)
WP_ADMIN_EMAIL=$(cat /run/secrets/my_wp_admin_email)
WP_EMAIL=$(cat /run/secrets/my_wp_email)

path=/var/www/wordpress

sed -i 's/listen\s*=\s*\/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# rm -f $path/index.nginx-debian.html

if [ ! "$(ls -A  $path)" ]; then

	wp core download --allow-root --path=$path --quiet

	# Genere le wp-config.php
	cd $path
	wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=$WP_HOST_DB --quiet

	# # CONFIG REDIS
	wp config set WP_REDIS_HOST $WP_HOST_REDIS --allow-root
	wp config set WP_REDIS_PORT $WP_PORT_REDIS --allow-root

	# CREATE ADMIN
	wp core install --allow-root --path=$path --url"=https://$DOMAIN_NAME" --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL

	# CREATE USER
	wp user create --allow-root --path=$path $WP_USER $WP_EMAIL --user_pass=$WP_PASSWD --role=$WP_USER_ROLE --quiet

	# PLUGIN REDIS DANS WORDPRESS
	wp plugin install redis-cache --activate --allow-root
	wp redis enable --allow-root
fi

php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
