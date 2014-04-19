FROM imanel/base
MAINTAINER Bernard Potocki <bernard.potocki@imanel.org>

# Add PPA and install PostgreSQL
RUN apt-add-repository -y 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
      postgresql-9.3 \
      postgresql-contrib-9.3 \
      postgresql-9.3-postgis

# Configure PostgreSQL
RUN sed -i "s/^data_directory = .*/data_directory = '\/data\/postgresql\/9.3\/main'/" /etc/postgresql/9.3/main/postgresql.conf && \
    sed -i "s/^#listen_addresses = .*/listen_addresses = '*'/" /etc/postgresql/9.3/main/postgresql.conf && \
    sed -i "s/^#ssl = off/ssl = true/" /etc/postgresql/9.3/main/postgresql.conf && \
    echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# Add run script
ADD services/postgresql /etc/service/postgresql

# Expose ports
EXPOSE 5432

# Add volume
VOLUME ["/data/postgresql"]

# Define an entry point
ENTRYPOINT ["/sbin/my_init"]
