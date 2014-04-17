## PostgreSQL Dockerfile

This repository contains **Dockerfile** of [PostgreSQL](http://www.postgresql.org) for [Docker](https://www.docker.io/)'s [trusted build](https://index.docker.io/u/imanel/postgresql/) published to the public [Docker Registry](https://index.docker.io/).

### Installation

1. Install [Docker](https://www.docker.io/).

2. Download [trusted build](https://index.docker.io/u/imanel/postgresql/) from public [Docker Registry](https://index.docker.io/): `docker pull imanel/postgresql`

### Usage

#### Run PostgreSQL server

    docker run -d --name postgresql -p 5432:5432 -e POSTGRESQL_USER=test -e POSTGRESQL_PASS=oe9jaacZLbR9pN -e POSTGRESQL_DB=test imanel/postgresql

#### Run PostgreSQL client

    docker run -i --rm -t --entrypoint="bash" --link postgresql:postgresql imanel/postgresql -c 'psql -h $POSTGRESQL_PORT_5432_TCP_ADDR'
