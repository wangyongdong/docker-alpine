# Dockerfile for building PostgreSQL images by alpine

[Docker PostgreSQL](https://github.com/wangyongdong/docker-alpine/tree/master/postgresql)

# 参考说明

`[onjin/docker-alpine-postgres](https://github.com/onjin/docker-alpine-postgres)`

# 部署说明

## 1.克隆 GitHub

 - `cd $HOME`
 - `git clone git@github.com:wangyongdong/docker-alpine.git`

## 2.构建并运行

 - `cd $HOME/docker-alpine/mysql`
 - `docker build -t postgresql .` 
 - `docker run --name postgresql -p 5432:5432 -e POSTGRES_PASSWORD=123456 -d postgresql`
