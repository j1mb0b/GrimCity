ARG FIVEM_NUM=6231
ARG FIVEM_VER=6231-dedae82e7ad4d8d568d9e109759873d9899758bb
ARG DATA_VER=3e8e6dfc010e87313e8be81ddb0ded5fc583624c
FROM wodby/mariadb:latest as builder
ARG FIVEM_VER
ARG DATA_VER

WORKDIR /output
USER root
RUN apk add --no-cache tini mariadb-dev tzdata xz \
    && rm -f /var/cache/apk/*
RUN wget http://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FIVEM_VER}/fx.tar.xz \
        && tar -xf fx.tar.xz --strip-components=1 --exclude alpine/dev --exclude alpine/proc --exclude alpine/run --exclude alpine/sys \
        && rm fx.tar.xz \
        && mkdir -p opt/cfx-server-data \
        && wget -O ${DATA_VER}.tar.gz https://codeload.github.com/citizenfx/cfx-server-data/tar.gz/${DATA_VER} \
        && tar -zxvf ${DATA_VER}.tar.gz --strip-components=1 -C opt/cfx-server-data \
        && rm ${DATA_VER}.tar.gz

ADD server.cfg opt/cfx-server-data
ADD resources.tar opt/cfx-server-data
ADD database.sql opt/cfx-server-data
ADD entrypoint usr/bin/entrypoint
RUN chmod +x /output/usr/bin/entrypoint

#================

FROM scratch

ARG FIVEM_VER
ARG FIVEM_NUM
ARG DATA_VER

LABEL org.label-schema.name="FiveM" \
      org.label-schema.url="https://fivem.net" \
      org.label-schema.description="FiveM is a modification for Grand Theft Auto V enabling you to play multiplayer on customized dedicated servers." \
      org.label-schema.version=${FIVEM_NUM}

COPY --from=builder /output/ /



WORKDIR /config

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen tzdata tini && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306
EXPOSE 30120

VOLUME ["/var/lib/mysql"]

# Default to an empty CMD, so we can use it to add seperate args to the binary
CMD [""]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/entrypoint"]
