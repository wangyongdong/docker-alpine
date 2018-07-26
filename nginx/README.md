# Dockerfile for building Nginx images by alpine
[Docker Nginx](https://github.com/wangyongdong/docker-alpine/tree/master/nginx)

## 部署说明


#### 1.安装并测试Docker
    安装方法请自己查找，也可以参考官方文档。


#### 2.获取镜像

`docker pull wangyongdong/docker-nginx`


#### 3.配置 `.conf/nginx.conf` 文件，及 `.conf/vhost/www.xxx.com.conf`


#### 4.运行容器

`docker run --name nginx -p 80:80 -d docker.io/wangyongdong/docker-nginx`


##### 挂载配置文件，及数据目录

挂载前先创建目录及文件，然后执行挂载，否则对报错。

`docker run --name nginx -p 80:80 \
-v $HOME/docker/lnmp-alpine/data/www:/usr/local/nginx/html \
-v $HOME/docker/lnmp-alpine/data/nginx/logs:/usr/local/nginx/logs \
-v $HOME/docker/lnmp-alpine/data/nginx/conf/nginx.conf:/usr/local/nginx/conf/nginx.conf \
-v $HOME/docker/lnmp-alpine/data/nginx/conf/vhost:/usr/local/nginx/conf/vhost \
--link php:php -d docker.io/wangyongdong/docker-nginx`


## 配置说明

 - -d: 后台运行容器，并返回容器ID
 - --name: 为容器指定一个名称
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 - --link: 添加链接到另一个容器

> 注意：挂载前，需要在宿主机的挂载目录创建配置文件，否则失败。


## 容器连接通信


#### 使用 --link，例如 --link php:php


#### 使用 --network

`docker network  ls`
`docker network create lnmp`

创建自定义网络lnmp后，可以使用 `--network lnmp` 命令，来设置网络，设置后，在 `nginx.conf` 中可以如下配置：


```apacheconfig
location ~ \.php$ {
    root /usr/local/nginx/html;
    fastcgi_pass php:9000; 
    fastcgi_index index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include fastcgi_params;
} 
```


> 如果使用了--link，或--network，实现了容器间的访问，此处可以直接写容器名称。
> 也可以使用 `docker inspect --format='{{.NetworkSettings.IPAddress}}' php` 获取IP后，填写php的ip地址


## 调试命令

`docker images | grep [REPOSITORY]` 查看镜像

`docker logs [CONTAINER ID]` 查看启动logs，分析错误原因

`docker exec -it [CONTAINER ID] /bin/sh` 进入容器中

`docker run -it -p 80:80 [IMAGE]` 查看执行过程

`netstat -ant | grep 80` 进入容器后，查看端口

`docker exec -it nginx ping php` 容器互ping，使用--link或--network时才可以


## 运行错误
    访问php502的话，查看 php 的IP，然后修改nginx的配置文件nginx.conf 修改fastcgi_pass为xxx.xxx.xxx.xxx:9000
    docker inspect --format='{{.NetworkSettings.IPAddress}}' php
