#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /Shopping-App-IRIS/tmp/pids/server.pid

# run the database
rake db:create
rake db:migrate
bundle pack
bundle install --path vendor/cache

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
