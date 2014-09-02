## PostgreSQL Dockerfile

This repository contains **Dockerfile** of [PostgreSQL](http://www.postgresql.org) for [Docker](https://www.docker.io/)'s [trusted build](https://index.docker.io/u/imanel/postgresql/) published to the public [Docker Registry](https://index.docker.io/).

### Installation

1. Install [Docker](https://www.docker.io/).

2. Download [trusted build](https://index.docker.io/u/imanel/postgresql/) from public [Docker Registry](https://index.docker.io/): `docker pull imanel/postgresql`

### Usage

#### Create database

    docker run -i -v $(pwd):/data/postgresql imanel/postgresql ./initdb -D /data/postgresql/$PG_VERSION/main -U superuser --pwfile=/data/postgresql/password.file

#### Run PostgreSQL server

    docker run -d -v $(pwd):/data/postgresql --name postgresql -p 5432:5432 imanel/postgresql
