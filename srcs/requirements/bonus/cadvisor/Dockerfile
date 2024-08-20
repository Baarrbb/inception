FROM debian:stable

RUN apt update -y && apt install -y curl

RUN curl -L https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -o cadvisor

RUN chmod +x cadvisor
RUN mv cadvisor /usr/local/bin

EXPOSE 8080

CMD ["cadvisor", "--store_container_labels=false"]

# CMD ["bash", "-c", "while true; do sleep 1000; done"]
