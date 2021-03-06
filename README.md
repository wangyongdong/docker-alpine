# Docker Images By Alpine

> 基于 PHP7，NGINX，MySql，Redis构建的 Lnmp

## Build Images

- [alpine](https://github.com/wangyongdong/docker-alpine/tree/master/alpine)
- [Redis](https://github.com/wangyongdong/docker-alpine/tree/master/Redis)
- [MySql](https://github.com/wangyongdong/docker-alpine/tree/master/mysql)
- [Nginx](https://github.com/wangyongdong/docker-alpine/tree/master/nginx)
- [PHP](https://github.com/wangyongdong/docker-alpine/tree/master/php)
- [MongoDB](https://github.com/wangyongdong/docker-alpine/tree/master/mongodb)

## Directory

```text
/
├── alpine                                        Alpine基础镜像
├── mysql                                         MySql镜像目录
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
├── nginx                                         Nginx镜像目录
│   ├── cert                                     HTTPS证书文件目录
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
├── php                                           PHP镜像目录
│   ├── conf                                     配置文件目录
│   │   ├── php.ini                             配置文件，在 Dockerfile 中指定，可修改配置后执行
│   │   ├── php-fpm.conf                        配置文件，可修改配置后执行
│   │   ├── www.conf                            配置文件，可修改配置后执行
│   ├── logs                                     日志目录
│   │   ├── error.log                           日志文件，可以在 php-fpm.conf 中配置
│   ├── Dockerfile                               dockerfile 文件
│   │   
├── redis                                         Redis镜像目录
│   ├── conf                                     配置文件目录
│   │   ├── redis.conf                          配置文件，在 Dockerfile 中指定，密码在此修改，可修改配置后执行
│   ├── data                                     数据目录
│   ├── logs                                     日志目录
│   │   ├── redis.log                           日志文件，可以在 redis.conf 中配置
│   ├── Dockerfile                               dockerfile 文件
├── www                                           代码存放目录
├── docker-compose.yml                            docker-compose 文件
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

### HTTPS

- 1. 将证书文件分别命名为 `nginx_ssl.pem`，`nginx_ssl.key`，存放在 `nginx/cert` 目录下
- 2. 修改 `nginx.conf` 或 虚拟主机配置文件 `vhost/www.xxx.conf`，示例查于 `www.site-https.com.conf`
- 3. 修改 `www.site-https.com.conf` 去掉 `default_server` ，不去掉的话会报错
- 4. `docker run` 时，加上 `-v $PWD/nginx/cert:/usr/local/nginx/cert`
- 5. 输入 `https://xxx` 测试

### Test

- 查询 nginx 容器 ip `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx`
- 添加到 host `172.20.0.3 www.site-test.com`

- www.site-test.com 查看phpinfo
- www.site-test.com/mysql.php 测试mysql，默认使用容器名连接，可以修改连接ip地址
- www.site-test.com/redis.php 测试redis，默认使用容器名连接，可以修改连接ip地址
    
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
