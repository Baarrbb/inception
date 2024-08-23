FROM debian:stable

RUN apt update -y && apt install -y curl

RUN curl -L https://github.com/bakins/php-fpm-exporter/releases/download/v0.6.1/php-fpm-exporter.linux.amd64 -o php-fpm-exporter

RUN chmod +x php-fpm-exporter
RUN mv php-fpm-exporter /usr/local/bin

CMD ["php-fpm-exporter", "--addr", "0.0.0.0:8080","--endpoint", "https://nginx:443/php_fpm_status"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]