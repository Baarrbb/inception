FROM debian:stable

RUN apt update -y && apt install -y monitorix iptables iproute2 curl openssl
RUN apt install -y libdbd-mysql-perl

COPY ./conf/monitorix.conf /etc/monitorix/monitorix.conf
COPY ./conf/nginx.pm /usr/lib/monitorix/nginx.pm
COPY ./conf/phpfpm.pm /usr/lib/monitorix/phpfpm.pm
# COPY ./conf/mysql.pm /usr/lib/monitorix/mysql.pm

# RUN cpan DBD::mysql

CMD ["monitorix", "-c", "/etc/monitorix/monitorix.conf", "-n"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]
