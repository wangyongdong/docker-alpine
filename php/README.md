# Dockerfile for building PHP7 images by alpine
[Docker PHP7](https://github.com/wangyongdong/docker-alpine/tree/master/php)

## 部署说明


### 安装并测试Docker

    安装方法请自己查找，也可以参考官方文档。

### 安装使用

#### 1.使用 Docker Hub 镜像

`docker run --name php -p 9000:9000 -d wangyongdong/docker-php`

> 建议使用此方法构建运行，如需挂载目录自行创建后进行挂载

#### 2.克隆 GitHub

 - `cd $HOME`
 - `git clone git@github.com:wangyongdong/docker-alpine.git`

##### 目录结构

```text
/
├── php                    
│   ├── conf                                        配置文件目录
│   │   ├── php.ini                                配置文件，在 Dockerfile 中指定，可修改配置后执行
│   │   ├── php-fpm.conf                           配置文件，可修改配置后执行
│   │   ├── www.conf                               配置文件，可修改配置后执行
│   ├── logs                                        日志目录
│   │   ├── error.log                              日志文件，可以在 php-fpm.conf 中配置
│   ├── Dockerfile                                  dockerfile 文件
├── www                                              代码存放处      
```

##### 构建并运行

 - `cd $HOME/docker-alpine/php`
 - `docker build -t php .` 
 - `docker run --name php -p 9000:9000 -d php`

> 若想挂载配置文件，数据目录和log日志，需要确保文件存在并可执行权限

 - `cd $HOME/docker-alpine`
 - `docker run --name php -p 9000:9000 \
-v $PWD/php/conf/php.ini:/etc/php7/php.ini \
-v $PWD/php/conf/php-fpm.conf:/etc/php7/php-fpm.conf \
-v $PWD/php/conf/www.conf:/etc/php7/php-fpm.d/www.conf \
-v $PWD/php/logs/error.log:/etc/php7/logs/error.log \
-v $PWD/www:/usr/local/nginx/html \
--link mysql:mysql --link redis:redis \
-d php`


### 配置说明

 - -d: 后台运行容器，并返回容器ID
 - --name: 为容器指定一个名称
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 - --link: 添加链接到另一个容器


### 容器连接通信

#### 使用 --link，例如 --link mysql:mysql

#### 创建网络，使用 --network

 - `docker network  ls`
 - `docker network create lnmp`

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


### 调试命令

`docker images | grep [REPOSITORY]` 查看镜像

`docker logs [CONTAINER ID]` 查看启动logs，分析错误原因

`docker exec -it [CONTAINER ID] /bin/sh` 进入容器中

`docker run -it -p 9000:9000 [IMAGE]` 查看执行过程

`netstat -ant | grep 9000` 进入容器后，查看端口

`docker exec -it nginx ping php` 容器互ping，使用--link或--network时才可以

`docker inspect --format='{{.NetworkSettings.IPAddress}}' xxx` 查看ip地址

### 运行错误

    访问php502的话，查看 php 的IP，然后修改nginx的配置文件nginx.conf 修改fastcgi_pass为xxx.xxx.xxx.xxx:9000
    docker inspect --format='{{.NetworkSettings.IPAddress}}' php
