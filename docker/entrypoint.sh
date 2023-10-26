#!/bin/bash
set -e

# Ensure the PostgreSQL Server is running before running your application
until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USERNAME" -d "$DB_DATABASE" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# Ensure the Redis Server is running before running your application
until echo PING | nc -w 1 redis 6379; do
  >&2 echo "Redis is unavailable - sleeping"
  sleep 1
done

if [ "$SCHEDULE_JOBS" = "true" ]
then
  # Update crontab file using whenever based on schedule.rb
  bundle exec whenever --update-crontab

  # Start cron in the foreground
  cron -f &
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
