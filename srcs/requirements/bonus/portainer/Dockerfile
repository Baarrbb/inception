FROM debian:stable

RUN apt update -y && apt install -y tar curl

RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.0/portainer-2.21.0-linux-amd64.tar.gz -o portainer.tar.gz

RUN tar -zxf portainer.tar.gz
RUN rm -rf portainer.tar.gz

# CMD ["bash", "-c", "while true; do sleep 1000; done"]

CMD ["/portainer/portainer"]
