#
# Dockerfile for building MySql images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/alpine
#

FROM alpine:3.9
LABEL wangyongdong <wydchn@gmail.com>

# 添加国内镜像源
# 清华
#RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main" > /etc/apk/repositories \
#    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/community" >> /etc/apk/repositories
# 中科大
RUN echo "https://mirrors.ustc.edu.cn/alpine/v3.9/main" > /etc/apk/repositories \
    && echo "https://mirrors.ustc.edu.cn/alpine/v3.9/community" >> /etc/apk/repositories

# Update repository and install useful packages
RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash bash-completion tzdata \
    && rm -f /var/cache/apk/*

# Define timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Define bash as default command
CMD ["/bin/bash"]