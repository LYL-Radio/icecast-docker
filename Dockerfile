FROM alpine:3.15

LABEL author "MajorcaDevs"
LABEL maintainer "me@maxep.me"
LABEL description "Icecast docker image"
LABEL org.opencontainers.image.source https://github.com/LYL-Radio/icecast-docker

ARG IC_VERSION=2.4.4-r7

RUN apk add --no-cache curl icecast=$IC_VERSION bash
RUN curl -sSL https://git.io/get-mo -o /usr/bin/mo && chmod +x /usr/bin/mo

ENV IC_ADMIN="icemaster@localhost" \
    IC_ADMIN_PASSWORD="hackme" \
    IC_ADMIN_USER="admin" \
    IC_CLIENT_TIMEOUT="30" \
    IC_HEADER_TIMEOUT="15" \
    IC_HOSTNAME="localhost" \
    IC_LISTEN_BIND_ADDRESS="0.0.0.0" \
    IC_LISTEN_MOUNT="stream" \
    IC_LISTEN_PORT="8000" \
    IC_LOCATION="Earth" \
    IC_MAX_CLIENTS="100" \
    IC_MAX_SOURCES="4" \
    IC_SOURCE_PASSWORD="hackme" \
    IC_SOURCE_TIMEOUT="10" \
    RADIO_MOUNT_NAME="stream" \
    RADIO_NAME="Dockerized Icecast" \
    RADIO_WEBSITE="https://github.com/LYL-Radio/icecast-docker" \
    GENRE="various" \
    GENERATE_TEMPLATE="False" \
    IC_QUEUE_SIZE="524288" \
    IC_BURST_SIZE="65535" \
    IC_MASTER_RELAY_PASSWORD="hackme" \
    ENABLE_RELAY="False" \
    IC_RELAY_MASTER_SERVER="changeme" \
    IC_RELAY_MASTER_PORT="8000" \
    IC_RELAY_MASTER_UPDATE_INTERVAL="120" \
    IC_RELAY_MASTER_PASSWORD="hackme" \
    IC_DEBUG_LOGLEVEL="3" \
    IC_LOGSIZE="10000"

RUN chown icecast:icecast /etc/icecast.xml

RUN ln -fs /dev/stdout /var/log/icecast/access.log && \
    ln -fs /dev/stderr /var/log/icecast/error.log

COPY template.xml /etc/template.xml
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8000

USER icecast

ENTRYPOINT [ "/entrypoint.sh", "icecast"]
CMD ["-c", "/etc/icecast.xml"]