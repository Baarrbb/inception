FROM debian:stable

RUN apt update -y && apt install -y nginx openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir static
COPY ./website/index.html /static/index.html

EXPOSE 8080

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
