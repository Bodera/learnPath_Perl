#!/bin/bash

# Read credentials from db_credentials.txt
source db_credentials.txt

# Build Docker image with build-time arguments
docker build \
  --build-arg POSTGRES_USER=$POSTGRES_USER \
  --build-arg POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  --build-arg POSTGRES_DB=$POSTGRES_DB \
  -t my-postgres-image .
