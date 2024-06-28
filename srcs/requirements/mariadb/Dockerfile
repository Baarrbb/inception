
FROM debian:stable

RUN apt update -y && apt install -y mariadb-server

ENV MYSQL_ROOT_PASSWORD=1234
ENV MYSQL_DATABASE=wordpress_db
ENV MYSQL_USER=wordpress_user
ENV MYSQL_PASSWORD=1234

# RUN groupadd -r mariadb && useradd -r -g mariadb user
# RUN chown -R user:mariadb /var/lib/mysql
# RUN chown -R user:mariadb /var/run/mysqld

# RUN useradd -r user
# RUN chown -R user /var/lib/mysql
# RUN mkdir -p /run/mysqld
# RUN chown -R user /run/mysqld

# COPY ./conf/test_mariadb.cnf /etc/mysql/mariadb.cnf

COPY ./conf/test_50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# USER user

EXPOSE 3306

COPY ./conf/test.sh /
RUN chmod +x test.sh

RUN mkdir -p /run/mysqld
RUN chown -R mysql /run/mysqld

CMD ["bash"]
# ENTRYPOINT ["/test.sh"]

# CMD ["mysqld"]




# SPECIFIES DISTRIBUTION
# FROM debian:buster

# ENV MYSQL_ROOT_PASSWORD=1234
# ENV MYSQL_DATABASE=wordpress_db
# ENV MYSQL_USER=wordpress_user
# ENV MYSQL_PASSWORD=1234

# # UPDATE AND INSTALLATION
# RUN apt-get update
# RUN apt install -y mariadb-server 

# # COPY THE CONF FOR THE BIND AND THE SQL SCRIPT FOR THE PRIVILEGE
# COPY ./conf/test_50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# # COPY THE SCRIPT IN THE IMAGES AND MODIFY THE EXECUTION RIGHTS OF IT
# COPY ./conf/test.sh /
# RUN  chmod +x /test.sh

# ENTRYPOINT [ "/test.sh" ]