# Dockerfile for building MySql images by alpine
[Docker MySql](https://github.com/wangyongdong/docker-alpine/tree/master/mysql)

## 部署说明


#### 1.安装并测试Docker
    安装方法请自己查找，也可以参考官方文档。


#### 2.获取镜像

`docker pull wangyongdong/docker-mysql`


#### 3.配置 `.conf/my.cnf` 文件


#### 4.运行容器

`docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql`


##### 挂载配置文件，及数据目录

`docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
-v $HOME/docker/lnmp/mysql/data:/var/lib/mysql \
-v $HOME/docker/lnmp/mysql/log:/var/log/mysql \
-v $HOME/docker/lnmp/mysql/conf:/etc/mysql \
-d mysql`


## 配置说明

 - -d: 后台运行容器，并返回容器ID
 - --name: 为容器指定一个名称
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 - e: 设置环境变量 MYSQL_ROOT_PASSWORD
 
> 注意：挂载前，需要在宿主机的挂载目录创建配置文件，否则失败。


## 调试命令

`docker images | grep [REPOSITORY]` 查看镜像

`docker logs [CONTAINER ID]` 查看启动logs，分析错误原因

`docker exec -it [CONTAINER ID] /bin/sh` 进入容器中

`docker run -it -p 3306:3306 [IMAGE]` 查看执行过程

`netstat -ant | grep 3306` 进入容器后，查看端口


## 获取IP
    
`docker inspect --format='{{.NetworkSettings.IPAddress}}' mysql`
    
获取到IP地址后，使用pdo连接即可。


## 命令

`show global variables like '%log%'` 查看各项日志是否开启