
FROM debian:stable

RUN apt update -y && apt install -y wget tar php-fpm zip
RUN wget https://wordpress.org/latest.zip
RUN unzip latest.zip
# RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz
# RUN rm -rf latest.tar.gz

COPY ./conf/wp-config.php /wordpress/wp-config.php

COPY ./conf/php.conf /etc/php/8.2/fpm/php-fpm.conf
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 9000

ENTRYPOINT ["./entry.sh"]
