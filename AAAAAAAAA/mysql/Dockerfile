#
# Dockerfile for building MySql images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/mysql
#

FROM wangyongdong/docker-alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

# Run Install
RUN apk update \
	&& apk add mysql mysql-client \
	&& addgroup mysql mysql \
	&& mkdir /scripts \
	&& rm -rf /var/cache/apk/*

# Copy configuration file and sh
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./scripts/startup.sh /scripts/startup.sh
RUN chmod +x /scripts/startup.sh

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql", "/var/log/mysql"]

# Define port
EXPOSE 3306

# Define run
ENTRYPOINT ["/scripts/startup.sh"]