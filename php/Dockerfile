#
# Dockerfile for building PHP7 images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/php
#

FROM wangyongdong/docker-alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

# Define Environments
ENV TIMEZONE            Asia/Shanghai
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

# Run Install
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update add --no-cache \
          git \
          curl \
          wget \
          php7 \
          php7-dev \
          php7-pear \
          php7-bcmath \
          php7-bz2 \
          php7-apcu \
          php7-calendar \
          php7-common \
          php7-ctype \
          php7-curl \
          php7-redis \
          php7-dom \
          php7-exif \
          php7-ftp \
          php7-fileinfo \
          php7-fpm \
          php7-gd \
          php7-gettext \
          php7-iconv \
          php7-intl \
          php7-json \
          php7-mcrypt \
          php7-mbstring \
          php7-mysqli \
          php7-mysqlnd \
          php7-opcache \
          php7-openssl \
          php7-pdo \
          php7-pdo_mysql \
          php7-pdo_pgsql \
          php7-pdo_sqlite \
          php7-pgsql \
          php7-phar \
          php7-posix \
          php7-session \
          php7-simplexml \
          php7-sockets \
          php7-sysvmsg \
          php7-sysvsem \
          php7-sysvshm \
          php7-shmop \
          php7-tokenizer \
          php7-xdebug \
          php7-xml \
          php7-xmlreader \
          php7-xmlwriter \
          php7-xsl \
          php7-zip \
          php7-zlib && \

    # Set environments
	sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
	sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
	sed -i "s|;*listen\s*=\s*/||g" /etc/php7/php-fpm.d/www.conf && \
	sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini && \

    # Cleaning up
	mkdir /var/www && \
	rm -rf /var/cache/apk/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install swoole
RUN apk add --no-cache make gcc g++ autoconf libressl openssl openssl-dev
RUN mkdir -p ~/swoole && \
        cd ~/swoole && \
        rm -rf ./swoole-src && \
    curl -o ./swoole.tar.gz https://github.com/swoole/swoole-src/archive/master.tar.gz -L && \
        tar zxvf ./swoole.tar.gz && \
        mv swoole-src* swoole-src && \
        cd swoole-src && \
    phpize && \
        ./configure --with-php-config=/usr/bin/php-config \
        --enable-openssl --with-openssl-dir=/usr/include/openssl \
        --enable-http2 \
        --enable-sockets && \
    make && make install && \
    echo "extension=swoole.so" > /etc/php7/conf.d/swoole.ini && \
        rm -rf ~/swoole

# Define Dir
RUN mkdir -p /usr/local/nginx/html \
    && mkdir -p /etc/php7/logs

# Define working directory.
WORKDIR /usr/local/nginx/html

# Define mountable directories.
VOLUME ["/usr/local/nginx/html"]

# Define port
EXPOSE 9000

# Define run
ENTRYPOINT ["/usr/sbin/php-fpm7", "-F", "-c", "/etc/php7/php.ini"]