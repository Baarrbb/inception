
FROM debian:stable

RUN apt update -y && apt install -y mariadb-server

COPY ./tools/setup_db.sh /
RUN chmod +x setup_db.sh

EXPOSE 3306

ENTRYPOINT ["./setup_db.sh"]
