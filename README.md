# README

## Standard

项目设置了Rubocop作为Linter, 所以提交的代码如果不按照规范将通过不了github action, 规则在[.rubocop.yaml](.rubocop.yml)

安装rubocop的详细步骤请看[这里](https://github.com/PrisonFrogs/docs/blob/master/RUBOCOP.md)

## System dependencies

本项目开发环境已经设置好了Docker Compose，所以不需要大部分系统依赖，但是需要先按照[这里](https://github.com/PrisonFrogs/docs/blob/master/RUBOCOP.md)安装好ruby版本，方便本地bundle和rails。详情看Commands指引。

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

本地bundle(需要先安装好)

```shell
bundle install
```

build项目(首次运行需要)

```shell
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

## Workflow

为了方便合作开发，请按照以下流程进行开发：

1.要开发新功能，从master分支切出feature分支

```shell
git checkout -b feature/some-features
```

2.提交代码到feature分支

```shell
git add . && git commit -m 'some messages'
git push origin feature/some-features
```

3.到github页面中创建pull request, assign给另外一个成员进行review(等待github action的pipeline通过)

4.当review完成后，合并代码到master分支
