FROM debian:stable

RUN apt update -y && apt install -y wget gpg apt-transport-https software-properties-common

RUN mkdir -p /etc/apt/keyrings/
RUN wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null

RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list

RUN apt update -y && apt install -y grafana

EXPOSE 3000

COPY ./conf/grafana.ini /etc/grafana/grafana.ini

COPY ./conf/dashboard.yml /etc/grafana/provisioning/dashboards/
COPY ./conf/datasource.yml /etc/grafana/provisioning/datasources/

COPY ./conf/dashboards/*.json /var/lib/grafana/dashboards/

COPY ./tools/modif.sh /modif.sh
RUN bash modif.sh


COPY ./tools/start.sh /
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]


# CMD ["grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini"]
