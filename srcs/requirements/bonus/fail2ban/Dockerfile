FROM debian:stable

RUN apt update -y && apt install -y fail2ban

COPY ./conf/jail.local /etc/fail2ban/jail.local

CMD ["bash", "-c", "while true; do sleep 1000; done"]
