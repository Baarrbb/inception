
FROM debian:stable

RUN apt update -y && apt install -y php-fpm curl php-mysql

COPY ./conf/php.conf /etc/php/8.2/fpm/php-fpm.conf
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 9000

ENTRYPOINT ["./entry.sh"]
