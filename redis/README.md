##  Dockerfile for building Redis images by alpine

[Docker Redis](https://github.com/wangyongdong/docker-alpine/tree/master/redis)

## 部署说明

### 安装并测试 Docker

    安装方法请自己查找，也可以参考官方文档。

### 安装

#### 1.使用 Docker Hub 镜像

- `docker run -d --name redis -p 36379:6379 --restart=always -d wangyongdong/docker-redis --requirepass "123456"`

> 建议使用此方法构建运行，如需挂载目录自行创建后进行挂载

#### 2.克隆 GitHub 

 - `cd $HOME`
 - `git clone git@github.com:wangyongdong/docker-alpine.git`

##### 目录结构

```text
/
├── redis                    
│   ├── conf                         配置文件目录
│   │   ├── redis.conf              配置文件，在 Dockerfile 中指定，可修改配置后执行
│   ├── data                         数据目录
│   ├── logs                         日志目录
│   │   ├── redis.log               日志文件，可以在 redis.conf 中配置
│   ├── Dockerfile                   dockerfile 文件
├── 
```

##### 构建并运行

 - `cd $HOME/docker-alpine/redis`
 - `docker build -t redis .` 
 - `docker run -d --name redis -p 36379:6379 --restart=always -d redis --requirepass "123456"`

> 若想挂载配置文件，数据目录和log日志，需要确保文件存在并可执行权限

 - `cd $HOME/docker-alpine`
 - `docker run -d --name redis -p 36379:6379 \
-v $PWD/redis/data:/data \
-v $PWD/redis/conf/redis.conf:/usr/local/redis/redis.conf \
-v $PWD/redis/logs/redis.log:/usr/local/logs/redis.log \
--restart=always -d redis --requirepass "123456"`

### 配置说明

 - -d: 后台运行容器，并返回容器ID；
 - --name: 为容器指定一个名称为；
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 - --requirepass: 设置 redis 密码

> 注意：挂载前，需要在宿主机的挂载目录创建配置文件，否则失败。

### 调试命令

`docker images | grep [REPOSITORY]` 查看镜像

`docker logs [CONTAINER ID]` 查看启动logs，分析错误原因

`docker exec -it [CONTAINER ID] /bin/sh` 进入容器中

`docker run -it -p 3306:3306 [IMAGE]` 查看执行过程

`netstat -ant | grep 3306` 进入容器后，查看端口

`docker inspect --format='{{.NetworkSettings.IPAddress}}' xxx` 查看ip地址

`show global variables like '%log%'` 查看各项日志是否开启

### 连接 Redis 服务

客户端：使用宿主机ip地址，加上 -p 指定的端口号，并输入 `--requirepass` 指定的密码即可。
程序连接：可以使用 `docker inspect redis` 查看ip连接，也可使用服务名 `redis` 连接
