#!/bin/bash

mv /wordpress/* /var/www/html/

echo "<?php echo 'Bienvenue sur mon site web!'; ?>" > /var/www/html/index.php

php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
