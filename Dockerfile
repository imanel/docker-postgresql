FROM imanel/base
MAINTAINER Bernard Potocki <bernard.potocki@imanel.org>

ENV PG_VERSION 9.3

# Install PostgreSQL and PostGIS
RUN apt-add-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" && \
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add - && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-$PG_VERSION postgresql-contrib-$PG_VERSION postgresql-$PG_VERSION-postgis-2.1 && \
    docker-cleanup

# Configure PostgreSQL
RUN sed -i "s/^data_directory = .*/data_directory = '\/data\/postgresql\/$PG_VERSION\/main'/" /etc/postgresql/$PG_VERSION/main/postgresql.conf && \
    sed -i "s/^#listen_addresses = .*/listen_addresses = '*'/" /etc/postgresql/$PG_VERSION/main/postgresql.conf && \
    echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf

USER postgres
WORKDIR /usr/lib/postgresql/9.3/bin

EXPOSE 5432
VOLUME ["/data/postgresql"]

# Define an entry point
CMD ["./postgres", "--config-file=/etc/postgresql/9.3/main/postgresql.conf"]
