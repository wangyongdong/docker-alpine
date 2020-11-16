# Dockerfile for building MySql images by alpine
[Docker MySql](https://github.com/wangyongdong/docker-alpine/tree/master/mysql)

## 部署说明


### 安装并测试Docker
`安装方法请自己查找，也可以参考官方文档。`

### 使用安装

#### 1.使用 Docker Hub 镜像

`docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d wangyongdong/docker-mysql`

> 建议使用此方法构建运行，如需挂载目录自行创建后进行挂载

#### 2.克隆 GitHub

 - `cd $HOME`
 - `git clone git@github.com:wangyongdong/docker-alpine.git`

##### 目录结构

```text
/
├── mysql                    
│   ├── conf                         配置文件目录
│   │   ├── my.cnf                  配置文件，在 Dockerfile 中指定，可修改配置后执行
│   ├── data                         数据目录
│   ├── logs                         日志目录
│   │   ├── error.log               错误日志，可以在 my.cnf 中配置
│   │   ├── slow_query.log          慢查询日志，可以在 my.cnf 中配置
│   ├── scripts                      dockerfile 文件
│   │   ├── startup.sh              mysql 初始化执行脚本
│   ├── Dockerfile                   dockerfile 文件
├── 
```

##### 构建并运行

 - `cd $HOME/docker-alpine/mysql`
 - `docker build -t mysql .` 
 - `docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql`

> 若想挂载配置文件，数据目录和log日志，需要确保文件存在并可执行权限

 - `cd $HOME/docker-alpine`
 - `docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
-v $PWD/mysql/data:/var/lib/mysql \
-v $PWD/mysql/logs:/var/log/mysql \
-v $PWD/mysql/conf:/etc/mysql \
-d mysql`


### 配置说明

 - -d: 后台运行容器，并返回容器ID
 - --name: 为容器指定一个名称
 - -p: 端口映射，格式为：主机(宿主)端口:容器端口
 - -v: 挂载宿主机目录/文件到容器的目录/文件
 - e: 设置环境变量 MYSQL_ROOT_PASSWORD
 
> 注意：挂载前，需要在宿主机的挂载目录创建配置文件，否则失败。

### 连接 MySql 服务
    
MySql构建成功后，可以使用客户端软件连接，也可以使用 `PHP` 进行连接

- 客户端：使用宿主机ip地址，加上 -p 指定的端口号，并输入 `MYSQL_ROOT_PASSWORD` 指定的密码即可。
- 程序连接：可以使用 `docker inspect mysql` 查看ip连接，也可使用服务名 `mysql` 连接
