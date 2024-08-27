FROM debian:stable

RUN apt update -y && apt install -y fail2ban iptables

COPY ./conf/jail.local /etc/fail2ban/jail.local

# RUN iptables -N DOCKER-USER

CMD ["fail2ban-server", "-f"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]

# CMD ["service", "fail2ban", "start"]

# RUN cp /etc/fail2ban/action.d/iptables.conf /etc/fail2ban/action.d/my_iptables.conf
# RUN sed -i 's/INPUT/FORWARD/g' /etc/fail2ban/action.d/my_iptables.conf

# RUN cp /etc/fail2ban/action.d/iptables-multiport-log.conf /etc/fail2ban/action.d/my_iptables-multiport-log.conf
# RUN sed -i 's/iptables.conf/my_iptables.conf/g' /etc/fail2ban/action.d/my_iptables-multiport-log.conf

# RUN cp /etc/fail2ban/action.d/iptables-multiport.conf /etc/fail2ban/action.d/my_iptables-multiport.conf
# RUN sed -i 's/iptables.conf/my_iptables.conf/g' /etc/fail2ban/action.d/my_iptables-multiport.conf

# RUN cp /etc/fail2ban/action.d/iptables-allports.conf /etc/fail2ban/action.d/my_iptables-allports.conf
# RUN sed -i 's/iptables.conf/my_iptables.conf/g' /etc/fail2ban/action.d/my_iptables-allports.conf

