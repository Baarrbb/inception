
FROM debian:stable

RUN apt update -y && apt install -y mariadb-server

RUN mkdir -p /var/log/mariadb
RUN chown -R mysql /var/log/mariadb
RUN mkdir -p /run/mysqld
RUN chown -R mysql /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup_db.sh /
RUN chmod +x setup_db.sh

EXPOSE 3306

ENTRYPOINT ["./setup_db.sh"]
