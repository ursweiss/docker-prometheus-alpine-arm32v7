FROM arm32v6/alpine:3.7

LABEL maintainer="Urs Weiss <docker-images@whity.ch>"

# Prometheus version and architecture to install
ENV PROM_VERSION=2.3.1
ENV PROM_SYSTEM=linux
ENV PROM_ARCH=armv7

WORKDIR /tmp/prom

RUN set -ex; \
    echo "*** Update packages ***"; \
    apk upgrade --no-cache; \
    echo "*** Install required packages ***"; \
    apk add --no-cache \
        curl; \
    echo "*** Get precompuled prometheus binary ***"; \
    curl --location --output prometheus.tar.gz  https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.${PROM_SYSTEM}-${PROM_ARCH}.tar.gz; \
    tar --strip-components=1 -xzf prometheus.tar.gz; \
    echo "*** Move all files into place **"; \
    mkdir -p /usr/share/prometheus /etc/prometheus /prometheus; \
    mv prometheus.yml /etc/prometheus/ ; \
    mv prometheus promtool /bin/; \
    mv console_libraries consoles /usr/share/prometheus/; \
    ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/; \
    chown -R nobody:nogroup /etc/prometheus /prometheus; \
    echo "*** Cleanup ***"; \
    apk del \
        curl \
        libcurl \
        libssh2; \
    rm -rf /var/cache/apk/*; \
    rm -rf /tmp/prom

USER        nobody
EXPOSE      9090
VOLUME      [ "/prometheus" ]
WORKDIR     /prometheus
ENTRYPOINT  [ "/bin/prometheus" ]
CMD         [ "--config.file=/etc/prometheus/prometheus.yml", \
              "--storage.tsdb.path=/prometheus", \
              "--web.console.libraries=/usr/share/prometheus/console_libraries", \
              "--web.console.templates=/usr/share/prometheus/consoles" ]
