#!/bin/bash
set -e

POSTGRESQL_VERSION=9.3

POSTGRESQL_BIN=/usr/lib/postgresql/$POSTGRESQL_VERSION/bin
POSTGRESQL_CONFIG_FILE=/etc/postgresql/$POSTGRESQL_VERSION/main/postgresql.conf
POSTGRESQL_DATA=/data/postgresql/$POSTGRESQL_VERSION/main

if [ ! -d $POSTGRESQL_DATA ]; then
    mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres $POSTGRESQL_DATA
    /sbin/setuser postgres $POSTGRESQL_BIN/initdb -D $POSTGRESQL_DATA
fi

if [ ! -f $POSTGRESQL_DATA/server.crt ]; then
  cp /etc/ssl/certs/ssl-cert-snakeoil.pem $POSTGRESQL_DATA/server.crt
  cp /etc/ssl/private/ssl-cert-snakeoil.key $POSTGRESQL_DATA/server.key
  chown postgres:postgres $POSTGRESQL_DATA/server.*
fi

/sbin/setuser postgres $POSTGRESQL_BIN/postgres --single --config-file=$POSTGRESQL_CONFIG_FILE <<< "ALTER USER postgres WITH PASSWORD '$POSTGRESQL_PASS';" > /dev/null
