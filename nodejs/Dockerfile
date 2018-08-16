#
# Dockerfile for building Node.js images
#
# https://github.com/wangyongdong/docker-alpine/tree/master/nodejs
#

FROM wangyongdong/docker-alpine:latest
LABEL wangyongdong <wydchn@gmail.com>

# Setting the npm version
ENV NPM_VER=6

# Run Install
RUN apk add --no-cache make gcc g++ libc-dev libpng-dev nodejs
RUN apk add --update nodejs nodejs-npm && npm install -g npm@$NPM_VER \
    && rm -rf /tmp/* \
    /var/cache/apk/* \
#    /root/.npm \
#    /root/.node-gyp \
#    /usr/include \
#    /usr/share/man \
    /usr/lib/node_modules/npm/man \
    /usr/lib/node_modules/npm/doc \
    /usr/lib/node_modules/npm/html

# Copy configuration file
RUN mkdir -p /app/src
COPY app.js /app/src

# Define mountable directories.
VOLUME ["/app/src"]

# Define working directory.
WORKDIR /app/src

# Define port
EXPOSE 3000

# Define run
CMD ["node", "app.js"]