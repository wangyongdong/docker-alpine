 # Dockerfile for building Node.js images by alpine
 [Docker Nginx](https://github.com/wangyongdong/docker-alpine/tree/master/nodejs)
 
## 部署说明
 
 
### 安装并测试Docker
 
    安装方法请自己查找，也可以参考官方文档。
 
### 使用安装
 
#### 1.使用 Docker Hub 镜像
 
`docker run --name nodejs -p 3000:3000 -d wangyongdong/docker-nodejs`
 
> 建议使用此方法构建运行，如需挂载目录自行创建后进行挂载
 
#### 2.克隆 GitHub
 
 - `cd $HOME`
 - `git clone git@github.com:wangyongdong/docker-alpine.git`
 
##### 目录结构
 
```text
/
├── nodejs                    
│   ├── app.js                                      js文件
│   ├── Dockerfile_make                             dockerfile 文件
│   ├── Dockerfile_nodealpine                       dockerfile 文件
│   ├── Dockerfile                                  dockerfile 文件
│  
```

##### 构建并运行

 - `cd $HOME/docker-alpine/nodejs`
 - `docker build -t nodejs .` 
 - `docker run --name nodejs -p 3000:3000 -d nodejs`

> 若想挂载配置文件，数据目录和log日志，需要确保文件存在并可执行权限

 - `cd $HOME/docker-alpine`
 - `docker run --name nodejs -p 3000:3000 \
-v $PWD/www:/app/src \
-d nodejs`


##### 配置说明

 - -d: 后台运行容器，并返回容器ID
 - --name: 为容器指定一个名称
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 
### 调试命令
 
`docker images | grep [REPOSITORY]` 查看镜像
 
`docker logs [CONTAINER ID]` 查看启动logs，分析错误原因
 
`docker exec -it [CONTAINER ID] /bin/sh` 进入容器中
 
`docker run -it -p 80:80 [IMAGE]` 查看执行过程
 
`docker run --name xxx -it xxx /bin/sh` 运行并进入容器
 
`netstat -ant | grep 80` 进入容器后，查看端口
 
`docker exec -it nginx ping php` 容器互ping，使用--link或--network时才可以

`docker inspect --format='{{.NetworkSettings.IPAddress}}' xxx` 查看ip地址
 
 
按 Ctrl-p + Ctrl-q。如果按 Ctrl-c 往往会让容器内应用进程终止，进而会终止容器
 