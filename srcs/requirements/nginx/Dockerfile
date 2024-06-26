FROM debian:latest

RUN apt update -y && apt install -y nginx

EXPOSE 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
