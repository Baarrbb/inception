FROM debian:stable

RUN apt update -y && apt install -y wget php-cgi
RUN apt install -y php-mysqli
RUN wget -O adminer.php https://www.adminer.org/latest.php

RUN mkdir -p /var/www
RUN mv /adminer.php /var/www/

EXPOSE 9000

CMD ["php-cgi", "-b", "0.0.0.0:9000"]
