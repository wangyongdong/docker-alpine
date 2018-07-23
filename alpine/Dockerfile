FROM alpine:latest

RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main" >> /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.4/community" >> /etc/apk/repositories

# Update repository and install useful packages
RUN apk update \
    && apk add bash bash-completion tzdata \
    && rm -f /var/cache/apk/*

# Define timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy configuration file
#COPY conf-bashrc /root/.bashrc
#COPY conf-gitconfig /root/.gitconfig

# Define working directory.
#WORKDIR /root

# Define bash as default command
CMD ["/bin/bash"]