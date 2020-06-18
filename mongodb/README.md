# Dockerfile for building Mongodb images by alpine
[Docker Nginx](https://github.com/wangyongdong/docker-alpine/tree/master/mongodb)

## 部署说明

### 安装并测试Docker

安装方法请自己查找，也可以参考官方文档。

### 使用安装

#### 版本需求

* apline 3.9
* MongoDB v4.0.5

#### 1.使用 Docker Hub 镜像

`cd $HOME`
`mkdir mongodb && cd mongodb`
`docker run --name mongodb -p 27017:27017 -d wangyongdong/docker-mongodb`
- `docker run -d --name mongodb -p 27017:27017 -v $PWD/db:/data/db -v $PWD/log:/data/log -it wangyongdong/docker-mongodb`

> 建议使用此方法构建运行，如需挂载目录自行创建后进行挂载

#### 2.克隆 GitHub

 - `cd $HOME`
 - `git clone git@github.com:wangyongdong/docker-alpine.git`

##### 目录结构

```text
/
├── mongodb                    
│   ├── conf                                        配置文件目录
│   ├── db                                          数据存放目录
│   ├── log                                         日志目录
│   ├── Dockerfile                                  dockerfile 文件
```

##### 构建并运行

- `cd $HOME/docker-alpine/mongodb`
- `docker build -t mongodb .` 
- `docker run -d --name mongodb -p 27017:27017 mongodb`

#### 目录挂载

> 若想挂载数据目录和log日志，需要确保文件存在并可执行权限

- `cd $HOME/docker-alpine/mongodb`
- `docker run -d --name mongodb -p 27017:27017 -v $PWD/db:/data/db -v $PWD/log:/data/log -it mongodb`

#### 进入容器

`docker exec -ti mongodb sh`

`docker exec -ti mongodb mongo`