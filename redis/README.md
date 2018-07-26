##  Dockerfile for building Redis images by alpine

[Docker Redis](https://github.com/wangyongdong/docker-alpine/tree/master/redis)

## 部署说明

#### 1.安装并测试Docker


    安装方法请自己查找，也可以参考官方文档。

#### 2.获取镜像

`docker pull docker pull wangyongdong/docker-redis`

#### 3.配置 `.conf/redis.conf` 文件


#### 4.运行容器

`docker run -d --name redis -p 36379:6379 --restart=always -d docker.io/wangyongdong/docker-redis --requirepass "123456"`

##### 挂载配置文件，及数据目录

挂载前先创建目录及文件，然后执行挂载，否则对报错。

`docker run -d --name redis -p 36379:6379 \
-v $HOME/docker-box/mount-data/docker-alpine/redis/data:/data \
-v $HOME/docker-box/mount-data/docker-alpine/redis/conf/redis.conf:/usr/local/redis/redis.conf \
--restart=always -d docker.io/wangyongdong/docker-redis --requirepass "123456"`

## 配置说明

 - -d: 后台运行容器，并返回容器ID；
 - --name: 为容器指定一个名称为；
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 - --requirepass: 设置 redis 密码

> 注意：挂载前，需要在宿主机的挂载目录创建配置文件，否则失败。



## 调试命令

`docker images | grep [REPOSITORY]` 查看镜像

`docker logs [CONTAINER ID]` 查看启动logs，分析错误原因

`docker exec -it [CONTAINER ID] /bin/sh` 进入容器中

`docker run -it -p 6379:6379 [IMAGE]` 查看执行过程

`netstat -ant | grep 6379` 进入容器后，查看端口

`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis` 获取IP，获取到IP地址后，使用php连接即可。
    
