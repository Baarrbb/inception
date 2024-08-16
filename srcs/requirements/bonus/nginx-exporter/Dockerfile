FROM debian:stable

RUN apt update -y && apt install -y curl tar
RUN curl -L https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.3.0/nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz -o nginx-prometheus-exporter.tar.gz

RUN tar -zxf nginx-prometheus-exporter.tar.gz
RUN rm -f nginx-prometheus-exporter.tar.gz
RUN mv nginx-prometheus-exporter /usr/local/bin

EXPOSE 9113

# CMD ["bash", "-c", "while true; do sleep 1000; done"]

CMD ["nginx-prometheus-exporter", "--no-nginx.ssl-verify", "--nginx.scrape-uri=https://nginx:443/nginx_status"]

