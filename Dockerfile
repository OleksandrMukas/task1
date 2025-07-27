FROM alpine:latest
WORKDIR /prometheus

LABEL maintainer="Oleksandr Mukas mukas2012@gmail.com>"
LABEL github_repo="https://github.com/OleksandrMukas/task1"

ARG PROM_VERSION="3.5.0"
ARG ARCH="amd64"
ARG OS="linux"

RUN apk add --no-cache wget tar && \
    wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.${OS}-${ARCH}.tar.gz && \
    tar -xzf prometheus-${PROM_VERSION}.${OS}-${ARCH}.tar.gz && \
    mv prometheus-${PROM_VERSION}.${OS}-${ARCH}/prometheus /bin/prometheus && \
    mv prometheus-${PROM_VERSION}.${OS}-${ARCH}/promtool /bin/promtool && \
    mv prometheus-${PROM_VERSION}.${OS}-${ARCH}/LICENSE /LICENSE && \
    mv prometheus-${PROM_VERSION}.${OS}-${ARCH}/NOTICE /NOTICE && \
    rm -rf prometheus-${PROM_VERSION}.${OS}-${ARCH}* && \
    apk del wget tar
COPY prometheus.yml /etc/prometheus/prometheus.yml

RUN chown -R nobody:nobody /etc/prometheus /prometheus && chmod g+w /prometheus

USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus" ]
