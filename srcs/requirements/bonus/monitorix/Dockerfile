FROM debian:stable

RUN apt update -y && apt install -y monitorix iptables iproute2 curl openssl
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/private.key -out /etc/ssl/certs/certificate.crt -subj "/C=/ST=/L=/O=/OU=/CN="

COPY ./conf/monitorix.conf /etc/monitorix/monitorix.conf


CMD ["monitorix", "-c", "/etc/monitorix/monitorix.conf", "-n"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]