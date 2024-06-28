
FROM debian:stable

RUN apt update -y && apt install -y mariadb-server

RUN mkdir -p /run/mysqld
RUN chown -R mysql /run/mysqld

ENV MYSQL_ROOT_PASSWORD=1234
ENV MYSQL_DATABASE=wordpress_db
ENV MYSQL_USER=wordpress_user
ENV MYSQL_PASSWORD=1234

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup_db.sh /
RUN chmod +x setup_db.sh

EXPOSE 3306

ENTRYPOINT ["./setup_db.sh"]
