FROM debian:stable

LABEL login="bsuc"

RUN apt update -y && apt install -y wget tar php-fpm php-mysqli
RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz
RUN rm -rf latest.tar.gz


COPY ./conf/test_wp-config.php /wordpress/wp-config.php

COPY ./conf/test_php.conf /etc/php/8.2/fpm/php-fpm.conf
COPY ./conf/test_www.conf /etc/php/8.2/fpm/pool.d/www.conf


COPY ./conf/entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 9000

ENTRYPOINT ["./entry.sh"]
