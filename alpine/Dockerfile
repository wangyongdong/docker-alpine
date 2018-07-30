#
# Dockerfile for building MySql images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/alpine
#

FROM alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

RUN echo "http://dl-4.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories \
    && echo "http://dl-4.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories

# Update repository and install useful packages
RUN apk update \
    && apk add bash bash-completion tzdata \
    && rm -f /var/cache/apk/*

# Define timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Define bash as default command
CMD ["/bin/bash"]