#
# Dockerfile for building Redis images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/redis
#

FROM wangyongdong/docker-alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

# Setting the redis version
ENV REDIS_VERSION 3.2.9

# Run Install
RUN apk --update add --no-cache --virtual .build-deps coreutils gcc linux-headers make musl-dev wget \
	&& wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz \
	&& mkdir -p /usr/local/redis \
	&& tar -xzf redis-$REDIS_VERSION.tar.gz -C /usr/local/redis --strip-components=1 \
	&& rm redis-$REDIS_VERSION.tar.gz \
	&& make -C /usr/local/redis \
	&& apk del .build-deps;

# Copy configuration file
COPY ./conf/redis.conf /usr/local/redis/redis.conf

# Define mountable directories.
RUN	mkdir /data \
    mkdir /usr/local/logs/
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define port
EXPOSE 6379

# Define run
ENTRYPOINT ["/usr/local/redis/src/redis-server", "/usr/local/redis/redis.conf"]