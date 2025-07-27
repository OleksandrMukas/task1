FROM alpine:latest
WORKDIR /prometheus

LABEL maintainer="Oleksandr Mukas mukas2012@gmail.com>"
LABEL github_repo="https://github.com/OleksandrMukas/task1"

ARG ARCH="amd64"
ARG OS="linux"
#ARG ARCH="arm64"
#ARG OS="darwin"

COPY .build/${OS}_${ARCH}/prometheus        /bin/prometheus
COPY .build/${OS}_${ARCH}/promtool          /bin/promtool
COPY prometheus.yml                         /etc/prometheus/prometheus.yml
COPY LICENSE                                /LICENSE
COPY NOTICE                                 /NOTICE

RUN chown -R nobody:nobody /etc/prometheus /prometheus && chmod g+w /prometheus

USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus" ]
