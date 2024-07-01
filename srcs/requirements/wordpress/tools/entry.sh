#!/bin/sh

# mv /wordpress/* /var/www/html/

# echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

# chown -R www-data:www-data /var/www/html



curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

useradd -m -s /bin/bash test
chown -R test /var/www/html
cp /etc/skel/.bashrc /home/test/

su test -c 'wp core download --path=/var/www/html'

mv /wp-config.php /var/www/html/

su test -c 'wp core install --path=/var/www/html --url=localhost --title="WP-CLI" --admin_user=wpcli --admin_password=wpcli --admin_email=test@test.test'


php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
