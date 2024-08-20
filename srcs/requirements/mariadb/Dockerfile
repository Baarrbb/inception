
FROM debian:stable

RUN apt update -y && apt install -y mariadb-server

COPY ./tools/setup_db.sh /
RUN chmod +x setup_db.sh

EXPOSE 3306

RUN chown -R mysql:mysql /var/lib/mysql

ENTRYPOINT ["./setup_db.sh"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]
