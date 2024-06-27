FROM debian:stable

LABEL login="bsuc"

RUN apt update -y && apt install -y nginx && apt install -y openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/certificates/localhost.pem /etc/ssl/certs/localhost.pem
COPY ./conf/certificates/localhost-key.pem /etc/ssl/private/localhost-key.pem

EXPOSE 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
