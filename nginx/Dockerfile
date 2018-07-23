#
# Dockerfile for building Nginx images
#
# https://github.com/wangyongdong/docker-alpine/nginx.git
#

FROM alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

#ENV TZ "Asia/Shanghai"

# Setting the nginx version
ENV NGINX_VERSION 1.8.1

# Run Install
RUN build_pkgs="build-base linux-headers openssl-dev pcre-dev wget zlib-dev file curl" \
  && runtime_pkgs="ca-certificates openssl pcre zlib" \
  && apk --update add ${build_pkgs} ${runtime_pkgs} \
  && cd /tmp \
  && wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz \
  && tar xzf nginx-$NGINX_VERSION.tar.gz \
  && cd /tmp/nginx-$NGINX_VERSION \
  && ./configure \
    --prefix=/usr/local/nginx \
    --sbin-path=/usr/local/nginx/sbin/nginx \
    --conf-path=/usr/local/nginx/conf/nginx.conf \
    --http-log-path=/usr/local/nginx/logs/access.log \
    --error-log-path=/usr/local/nginx/logs/error.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --with-pcre \
    --with-http_spdy_module \
#    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-file-aio \
    --with-ipv6 \
    --with-threads \
    --with-debug \
  && make \
  && make install \
  && rm -rf /tmp/* \
  && apk del ${build_pkgs} \
  && rm -rf /var/cache/apk/*

# Copy configuration file
COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY conf/vhost/* /usr/local/nginx/conf/vhost/
RUN chmod 755 /usr/local/nginx/conf/nginx.conf

# Define working directory.
WORKDIR /usr/local/nginx/html

# Define mountable directories.
VOLUME ["/usr/local/nginx/html", "/usr/local/nginx/logs", "/usr/local/nginx/conf"]

# Define port
EXPOSE 80 443

# 若要使用https，请将以下三个注释去掉,并在ssl文件夹中添加你自己申请的两个证书文件
#RUN mkdir -p /etc/nginx/cert
#COPY ssl/nginx.pem /etc/nginx/cert/nginx.pem
#COPY ssl/nginx.key /etc/nginx/cert/nginx.key

# Define run
ENTRYPOINT ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]