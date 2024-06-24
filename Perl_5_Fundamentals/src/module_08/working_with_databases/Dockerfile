# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Create a directory for PostgreSQL data
RUN mkdir -p /var/lib/postgresql/data

# Make the directory owned by the postgres user
RUN chown -R postgres:postgres /var/lib/postgresql/data

# Set the directory as the default PostgreSQL data directory
ENV PGDATA /var/lib/postgresql/data

# Arguments passed from the shell script
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

# Environment variables
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV POSTGRES_DB=$POSTGRES_DB

# Copy SQL scripts into the image
COPY init_db.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# Use a volume for persisting data
VOLUME /var/lib/postgresql/data
