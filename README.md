# docker-php

Docker && Ubuntu 16.04 && Apache2 && Php && Mysqli && Sqlsrv && PhpMyAdmin

## Requirements

* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

## About this docker's settings

- ubuntu:16.04
- apache2
- php 7
- sqlsrv
- mysqli

## Before installation

Before installation change this [line](https://github.com/emalherbi/docker-php-7/blob/master/docker-compose.yml#L10).

## Installation

```bash
docker-compose up -d --build --force-recreate --remove-orphans
```

## Document Root

```
www
|- index-info.php
```

## Server Root

```
localhost:9086
```
