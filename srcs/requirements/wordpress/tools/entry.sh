#!/bin/sh

mv /wordpress/* /var/www/html/

chown -R www-data:www-data /var/www/html

# echo "<?php echo 'Bienvenue sur mon site web!'; ?>" > /var/www/html/index.php

echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
