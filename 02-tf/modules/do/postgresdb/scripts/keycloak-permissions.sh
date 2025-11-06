#!/bin/sh

export ENV=$1
export PG_CONN_STRING=$2

psql "$PG_CONN_STRING" -c \
  "CREATE SCHEMA IF NOT EXISTS keycloak AUTHORIZATION keycloak; GRANT ALL PRIVILEGES ON SCHEMA keycloak TO keycloak;"
