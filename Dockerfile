FROM imanel/base
MAINTAINER Bernard Potocki <bernard.potocki@imanel.org>

# Add PPA and install PostgreSQL
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      postgresql-9.1 \
      postgresql-contrib-9.1 \
      postgresql-9.1-postgis

# Configure PostgreSQL
RUN sed -i "s/^data_directory = .*/data_directory = '\/data\/postgresql\/9.1\/main'/" /etc/postgresql/9.1/main/postgresql.conf && \
    sed -i "s/^#listen_addresses = .*/listen_addresses = '*'/" /etc/postgresql/9.1/main/postgresql.conf && \
    sed -i "s/^#ssl = off/ssl = true/" /etc/postgresql/9.1/main/postgresql.conf && \
    echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/9.1/main/pg_hba.conf

# Add run script
ADD services/postgresql /etc/service/postgresql

# Expose ports
EXPOSE 5432

# Add volume
VOLUME ["/data/postgresql"]

# Define an entry point
ENTRYPOINT ["/sbin/my_init"]
