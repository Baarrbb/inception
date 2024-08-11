FROM debian:stable

RUN apt update -y && apt install -y redis-server

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]
