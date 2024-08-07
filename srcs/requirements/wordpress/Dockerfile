
FROM debian:stable

RUN apt update -y && apt install -y php-fpm curl php-mysql

# COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["./entry.sh"]
