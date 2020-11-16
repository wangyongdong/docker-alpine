#
# Dockerfile for building Nginx images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/nginx
# Alpine Linux 自 3.5.0 起 已经将原有的 OpenSSL 替换为 LibreSSL 了：https://alpinelinux.org/posts/Alpine-3.5.0-released.html
#

FROM wangyongdong/docker-alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

# Setting the nginx version
ENV NGINX_VERSION 1.17.1

RUN apk --update add pcre libbz2 ca-certificates libressl && rm /var/cache/apk/*

RUN adduser -h /usr/local/nginx -D -s /bin/sh nginx

# add compilation env, build required C based gems and cleanup
RUN apk --update add --virtual build_deps build-base zlib-dev pcre-dev libressl-dev \
    && wget -O - http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar xzf - \
    && cd nginx-$NGINX_VERSION \
    && ./configure \
       --prefix=/usr/local/nginx \
       --sbin-path=/usr/local/nginx/sbin/nginx \
       --conf-path=/usr/local/nginx/conf/nginx.conf \
       --http-log-path=/usr/local/nginx/logs/access.log \
       --error-log-path=/usr/local/nginx/logs/error.log \
       --pid-path=/var/run/nginx.pid \
       --lock-path=/var/run/nginx.lock \
       --http-client-body-temp-path=/var/cache/nginx/client_temp \
       --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
       --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
       --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
       --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
       --user=nginx \
       --group=nginx \
       --with-http_addition_module \
       --with-http_auth_request_module \
       --with-http_gunzip_module \
       --with-http_gzip_static_module \
       --with-http_realip_module \
       --with-http_ssl_module \
       --with-http_stub_status_module \
       --with-http_sub_module \
       --with-http_v2_module \
       --with-threads \
       --with-stream \
       --with-stream_ssl_module \
       --without-http_memcached_module \
       --without-mail_pop3_module \
       --without-mail_imap_module \
       --without-mail_smtp_module \
       --with-pcre-jit \
       --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security' \
       --with-ld-opt='-Wl,-z,relro -Wl,--as-needed' \
    && make install \
    && cd .. && rm -rf nginx-$NGINX_VERSION \
    && mkdir /var/cache/nginx \
    && apk del build_deps && rm /var/cache/apk/*

# Copy configuration file
COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY conf/vhost/www.site-test.com.conf /usr/local/nginx/conf/vhost/www.site-test.com.conf

RUN chmod 755 /usr/local/nginx/conf/nginx.conf \
  && mkdir -p /usr/local/nginx/cert

# Define working directory.
WORKDIR /usr/local/nginx/html

# Define mountable directories.
VOLUME ["/usr/local/nginx/html", "/usr/local/nginx/logs", "/usr/local/nginx/conf"]

# Define port
EXPOSE 80 443

# Define run
ENTRYPOINT ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]