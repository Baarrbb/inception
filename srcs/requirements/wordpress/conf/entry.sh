#!/bin/bash

mv /wordpress/* /var/www/html/

php-fpm8.2 -F -y /etc/php/8.2/fpm/php-fpm.conf
