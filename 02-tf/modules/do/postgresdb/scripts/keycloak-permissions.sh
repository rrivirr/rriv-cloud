#!/bin/sh

export ENV=$1
export PG_CONN_STRING=$2

psql "$PG_CONN_STRING" -c \
  "GRANT USAGE ON SCHEMA keycloak TO keycloak; GRANT CREATE ON SCHEMA keycloak TO keycloak;"
