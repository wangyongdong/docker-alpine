#
# Dockerfile for building mongodb images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/php
#
FROM wangyongdong/docker-alpine:latest
LABEL maintainer="wydchn@gmail.com"

# v4.0.5
RUN apk add --no-cache mongodb && apk add --no-cache bash && rm -rf /var/cache/apk/*

# set env
ENV MONGODB_STORAGE_ENGINE="wiredTiger"
ENV MONGODB_JOURNALING="nojournal"
ENV MONGODB_PORT="27017"
ENV MONGODB_HOST="0.0.0.0"
ENV MONGODB_MOUNTPOINT="/data"
ENV MONGODB_DB="$MONGODB_MOUNTPOINT/db"
ENV MONGODB_LOG="$MONGODB_MOUNTPOINT/log"

RUN mkdir -p $MONGODB_DB && mkdir -p $MONGODB_LOG

VOLUME $MONGODB_DB
VOLUME $MONGODB_LOG

WORKDIR $MONGODB_MOUNTPOINT

EXPOSE $MONGODB_PORT

# run
CMD mongod --bind_ip "$MONGODB_HOST" --dbpath "$MONGODB_DB" --logpath "$MONGODB_LOG/mongod.log" --port "$MONGODB_PORT" --storageEngine "$MONGODB_STORAGE_ENGINE" --"$MONGODB_JOURNALING"
