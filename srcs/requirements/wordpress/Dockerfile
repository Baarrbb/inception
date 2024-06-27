FROM debian:stable

LABEL login="bsuc"

RUN apt update -y && apt install -y php-fpm wget tar
RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz
RUN rm -rf latest.tar.gz

EXPOSE 9000
