# Dockerfile for building MySql images by alpine

[Docker MySql](https://github.com/wangyongdong/docker-alpine/tree/master/mysql)

# 部署说明

## 使用安装

### 支持参数

- `MYSQL_ROOT_PWD` : root Password default is "mysql"
- `MYSQL_USER`     : new UserName
- `MYSQL_USER_PWD` : new User Password
- `MYSQL_USER_DB`  : new Database for new User

### 目录结构

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

### 1.使用 Docker Hub 镜像

- `docker pull wangyongdong/docker-mysql`

- `docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PWD=123456 -d wangyongdong/docker-mysql`

> 建议使用此方法构建运行，如需挂载目录自行创建后进行挂载

### 2.克隆 GitHub

1. 克隆代码

- `cd $HOME`
- `git clone git@github.com:wangyongdong/docker-alpine.git`

2. 构建并运行容器

- `cd $HOME/docker-alpine/mysql`
- `docker build -t mysql .` 
- `docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PWD=123456 -d mysql`

3. 若想挂载配置文件，数据目录和log日志，需要确保文件存在并可执行权限

- `cd $HOME/docker-alpine`

- 挂载目录，并设置 root 密码
```text
docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PWD=123456 \
-v $PWD/mysql/data:/var/lib/mysql \
-v $PWD/mysql/logs:/var/log/mysql \
-d mysql
```

- 挂载目录，设置 root 密码，创建用户及用户密码
```
docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PWD=123456 \
-e MYSQL_USER=dev -e MYSQL_USER_PWD=dev \
-v $PWD/mysql/data:/var/lib/mysql \
-v $PWD/mysql/logs:/var/log/mysql \
-d mysql
```

- 挂载目录，设置 root 密码，创建用户及用户密码，并创建数据库
```
docker run --name mysql -p 33306:3306 -e MYSQL_ROOT_PWD=123456 \
-e MYSQL_USER=dev -e MYSQL_USER_PWD=dev \
-e MYSQL_USER_DB=userdb \
-v $PWD/mysql/data:/var/lib/mysql \
-v $PWD/mysql/logs:/var/log/mysql \
-d mysql
```

## 配置说明

- -d: 后台运行容器，并返回容器ID
- --name: 为容器指定一个名称
- -p: 端口映射，格式为：主机(宿主)端口:容器端口
- -v: 挂载宿主机目录/文件到容器的目录/文件
- e: 设置环境变量 如:`MYSQL_ROOT_PWD` `MYSQL_USER` `MYSQL_USER_PWD` `MYSQL_USER_DB`

> 注意：挂载前，需要在宿主机的挂载目录创建配置文件，否则失败。

## 连接 MySql 服务
    
MySql构建成功后，可以使用客户端软件连接，也可以使用 `PHP` 进行连接

- 客户端：使用宿主机ip地址，加上 -p 指定的端口号，并输入 `MYSQL_ROOT_PWD` 指定的密码即可。
- 程序连接：可以使用 `docker inspect mysql` 查看ip连接，也可使用服务名 `mysql` 连接
