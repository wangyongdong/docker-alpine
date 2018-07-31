# Docker Images By Alpine
> 基于 PHP7，NGINX，MySql，Redis构建的 Lnmp

## Build Images

- [alpine](https://github.com/wangyongdong/docker-alpine/tree/master/alpine)
- [Redis](https://github.com/wangyongdong/docker-alpine/tree/master/Redis)
- [MySql](https://github.com/wangyongdong/docker-alpine/tree/master/mysql)
- [Nginx](https://github.com/wangyongdong/docker-alpine/tree/master/nginx)
- [PHP](https://github.com/wangyongdong/docker-alpine/tree/master/php)


## Directory

```text
/
├── alpine                   alpine基础镜像
├── mysql                    MySql镜像目录
│   ├── conf                                     配置文件目录
│   │   ├── my.cnf                              配置文件，在 Dockerfile 中指定，可修改配置后执行
│   ├── data                                     数据目录
│   ├── logs                                     日志目录
│   │   ├── error.log                           错误日志，可以在 my.cnf 中配置
│   │   ├── slow_query.log                      慢查询日志，可以在 my.cnf 中配置
│   ├── scripts                                  dockerfile 文件
│   │   ├── startup.sh                          mysql 初始化执行脚本
│   ├── Dockerfile                               dockerfile 文件
│   │ 
├── nginx                    Nginx镜像目录
│   ├── conf                                     配置文件目录
│   │   ├── nginx.conf                          配置文件，在 Dockerfile 中指定，可修改配置后执行
│   │   ├── vhost                               虚拟主机配置文件
│   │   │    ├── www.site-https.com.conf       虚拟主机配置示例
│   │   │    ├── www.site-test.com.conf        虚拟主机配置示例
│   ├── logs                                     日志目录
│   │   ├── access.log                          日志文件，可以在 nginx.conf 中配置
│   │   ├── error.log                           日志文件，可以在 nginx.conf 中配置
│   ├── Dockerfile                               dockerfile 文件
│   │ 
├── php                       PHP镜像目录
│   ├── conf                                     配置文件目录
│   │   ├── php.ini                             配置文件，在 Dockerfile 中指定，可修改配置后执行
│   │   ├── php-fpm.conf                        配置文件，可修改配置后执行
│   │   ├── www.conf                            配置文件，可修改配置后执行
│   ├── logs                                     日志目录
│   │   ├── error.log                           日志文件，可以在 php-fpm.conf 中配置
│   ├── Dockerfile                               dockerfile 文件
│   │   
├── redis                     PHP镜像目录
│   ├── conf                                     配置文件目录
│   │   ├── redis.conf                          配置文件，在 Dockerfile 中指定，可修改配置后执行
│   ├── data                                     数据目录
│   ├── logs                                     日志目录
│   │   ├── redis.log                           日志文件，可以在 redis.conf 中配置
│   ├── Dockerfile                               dockerfile 文件
├── www                       代码存放目录
├── docker-compose.yml        docker-compose 文件
```

## Use

### Require

    - `git`
    - `docker`
    - `docker-compose`

### RUN

    `git clone git@github.com:wangyongdong/docker-alpine.git` 克隆项目
    `cd docker-alpine`
    `docker-compose up -d` 运行启动

### Test

    - 127.0.0.1     访问链测试
    - 127.0.0.1/site-test/index.php 查看phpinfo
    - 127.0.0.1/site-test/mysql.php 测试mysql，默认使用容器名连接，可以修改连接ip地址
    - 127.0.0.1/site-test/redis.php 测试redis，默认使用容器名连接，可以修改连接ip地址
    
### DEBUG

    - `docker-compose ps` 查看运行容器
    - `docker-compose stop` 停止容器
    - `docker-compose rm` 删除容器
    - `docker inspect xxx` 查看运行容器ip

### Custom
   
   在配置文件中可以修改对应配置，及挂载目录    
       
   - 自定义端口
   - 自定义数据库密码
   - 自定义redis密码
   - 自定义挂载目录，确保挂载目录有相应的文件
   
## Document

- [Alpine Linux](https://alpinelinux.org/)
- [Alpine Official Repository](https://hub.docker.com/_/alpine/)
- [Alpine Images](https://store.docker.com/images/alpine)

