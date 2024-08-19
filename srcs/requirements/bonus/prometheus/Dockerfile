FROM debian:stable

RUN apt update -y && apt install -y prometheus

# CMD ["bash", "-c", "while true; do sleep 1000; done"]

COPY ./conf/prometheus.yml /etc/prometheus/prometheus.yml

# CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml"]

# CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml", "--web.external-url=https://bsuc.42.fr/prometheus", "--web.route-prefix=/prometheus"]


CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml", "--web.external-url=/prometheus/", "--web.route-prefix=/prometheus/", "--log.level=warn"]
