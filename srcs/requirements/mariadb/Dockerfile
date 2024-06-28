FROM debian:stable

RUN apt update -y && apt install -y mariadb-server

# ENV MYSQL_ROOT_PASSWORD=1234
# ENV MYSQL_DATABASE=wordpress_db
# ENV MYSQL_USER=wordpress_user
# ENV MYSQL_PASSWORD=1234

# RUN groupadd -r mariadb && useradd -r -g mariadb user
# RUN chown -R user:mariadb /var/lib/mysql
# RUN chown -R user:mariadb /var/run/mysqld

RUN useradd -r user
RUN chown -R user /var/lib/mysql
RUN mkdir -p /run/mysqld
RUN chown -R user /run/mysqld

# COPY ./conf/test_mariadb.cnf /etc/mysql/mariadb.cnf
COPY ./conf/test_50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

USER user

EXPOSE 3306

CMD ["mysqld"]
# CMD ["bash"]
