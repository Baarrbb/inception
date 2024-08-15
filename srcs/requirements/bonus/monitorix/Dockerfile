FROM debian:stable

RUN apt update -y && apt install -y monitorix iptables iproute2 curl openssl

COPY ./conf/monitorix.conf /etc/monitorix/monitorix.conf
COPY ./conf/nginx.pm /usr/lib/monitorix/nginx.pm


CMD ["monitorix", "-c", "/etc/monitorix/monitorix.conf", "-n"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]