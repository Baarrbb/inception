FROM debian:stable

RUN apt update -y && apt install -y curl tar

RUN curl -L https://github.com/prometheus/mysqld_exporter/releases/download/v0.15.1/mysqld_exporter-0.15.1.linux-amd64.tar.gz -o mysqld-exporter.tar.gz

RUN tar zxf mysqld-exporter.tar.gz
RUN mv /mysqld_exporter-0.15.1.linux-amd64/mysqld_exporter /usr/local/bin

COPY ./conf/my.cnf /

CMD ["mysqld_exporter", "--config.my-cnf=/my.cnf"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]
