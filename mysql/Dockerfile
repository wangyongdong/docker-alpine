#
# Dockerfile for building MySql images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/mysql
#

FROM wangyongdong/docker-alpine:latest
LABEL maintainer ="wangyongdong <wydchn@gmail.com>"

ENV MYSQL_VERSION=10.3.25-r0

# 添加国内镜像源

# Run Install
RUN apk add --no-cache mysql=${MYSQL_VERSION} mysql-client=${MYSQL_VERSION} mariadb-server-utils=${MYSQL_VERSION} && \
	addgroup mysql mysql && \
	mkdir /scripts && \
	rm -rf /var/cache/apk/*

# Copy configuration file and sh
#COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./scripts/startup.sh /scripts/startup.sh
RUN chmod +x /scripts/startup.sh

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc", "/var/log/mysql"]

# Define port
EXPOSE 3306

# Define run
ENTRYPOINT ["/scripts/startup.sh"]
