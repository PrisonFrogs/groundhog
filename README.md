# README

## Ruby version

3.1.0

## System dependencies

本项目开发环境已经设置好了Docker Compose，所以不需要任何系统依赖。详情看Commands指引。

## Docker

项目设置了docker-compose方便我们设置开发环境，里面包含了redis, app, mysql的镜像，并且设置了redis, app, mysql的端口(将默认的段位的第一位暴露为9)。

端口:

```text
  app: 9000
  mysql: 9306
  redis: 9379
```

本地app地址: `localhost:9000`

## Commands

```build项目(首次运行需要)
  docker-compose build && docker-compose run --rm groundhog_app bundle install
```

创建Docker内的数据库(首次运行需要)

```shell
docker-compose run groundhog_app rails db:create
```

运行Migration

```shell
docker-compose run groundhog_app rails db:migrate
```

启动本项目

```shell
docker-compose build && docker-compose up
```

运行Rails指令

```shell
docker-compose run groundhog_app rails <command>
```
