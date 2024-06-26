FROM debian:latest

RUN apt update -y && apt install -y nginx && apt install -y openssl

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./certificates/certificate.crt /etc/ssl/certs/certificate.crt
COPY ./certificates/private.key /etc/ssl/private/private.key

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
