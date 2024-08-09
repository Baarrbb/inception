
FROM debian:stable

RUN apt update -y && apt install -y php-fpm curl php-mysql

COPY ./tools/entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 9000

ENTRYPOINT ["./entry.sh"]
