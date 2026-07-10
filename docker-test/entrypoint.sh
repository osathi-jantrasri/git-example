#!/bin/sh
set -e

DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-3306}"
MAX_TRIES=30

echo "Waiting for ${DB_HOST}:${DB_PORT}..."

i=0
until node -e "require('net').createConnection($DB_PORT,'$DB_HOST').on('connect',()=>process.exit(0)).on('error',()=>process.exit(1))"; do
  i=$((i + 1))
  if [ "$i" -ge "$MAX_TRIES" ]; then
    echo "Timed out waiting for ${DB_HOST}:${DB_PORT}"
    exit 1
  fi
  sleep 2
done

echo "Database is ready. Starting application."
exec "$@"