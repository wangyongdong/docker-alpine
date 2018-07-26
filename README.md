# Docker Images By Alpine

## Images

- [alpine](https://github.com/wangyongdong/docker-alpine/tree/master/alpine)
- [Redis](https://github.com/wangyongdong/docker-alpine/tree/master/Redis)
- [MySql](https://github.com/wangyongdong/docker-alpine/tree/master/mysql)
- [Nginx](https://github.com/wangyongdong/docker-alpine/tree/master/nginx)
- [PHP](https://github.com/wangyongdong/docker-alpine/tree/master/php)


### Custom
       
   - 自定义端口
   - 自定义数据库密码
   - 自定义redis密码
   - 自定义挂载目录，确保挂载目录有相应的文件
   
### RUN
       
   - `cd xxx/`
   - `git clone git@github.com:wangyongdong/docker-alpine.git`
   - `docker-compose up -d`
   
### DEBUG

   - `docker-compose ps` 查看运行容器
   - `docker-compose stop` 停止容器
   - `docker-compose rm` 删除容器
   - `docker inspect xxx` 查看ip
   
### Test

   - 127.0.0.1/index.php 查看phpinfo
   - 127.0.0.1/mysql.php 测试mysql，默认使用容器名连接，可以修改连接ip地址
   - 127.0.0.1/redis.php 测试redis，默认使用容器名连接，可以修改连接ip地址


## Document

- [Alpine Linux](https://alpinelinux.org/)
- [Alpine Official Repository](https://hub.docker.com/_/alpine/)
- [Alpine Images](https://store.docker.com/images/alpine)

