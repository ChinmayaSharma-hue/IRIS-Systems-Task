# IRIS-Systems-Task

### Task 1
Pack the rails application in a docker container image.

- Dockerfile
    ```
    FROM ruby:2.5.1-stretch
    RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mysql-server
    RUN mkdir /Shopping-App-IRIS
    WORKDIR /Shopping-App-IRIS
    ADD Gemfile /Shopping-App-IRIS/Gemfile
    ADD Gemfile.lock /Shopping-App-IRIS/Gemfile.lock
    ADD . /Shopping-App-IRIS

    EXPOSE 3000
    RUN bundle install


    COPY entrypoint.sh /usr/bin/
    RUN chmod +x /usr/bin/entrypoint.sh
    ENTRYPOINT ["entrypoint.sh"]

    CMD [ "rails", "server", "-b", "0.0.0.0" ]
    ```
- Entrypoint script (entrypoint.sh)
    ```
    #!/bin/bash
    set -e

    # Remove a potentially pre-existing server.pid for Rails.
    rm -f /Shopping-App-IRIS/tmp/pids/server.pid

    # Resetting the database password
    /etc/init.d/mysql stop

    mysqld_safe --init-file=/tmp/sqlinit.sql

    /etc/init.d/mysql stop
    /etc/init.d/mysql start
    export SHOP1_DATABASE_PASSWORD='chinmay2002'

    # Create and migrate the database
    rake db:create
    rake db:migrate
    bundle pack
    bundle install --path vendor/cache

    # Execute the container's main process (what's set as CMD in the Dockerfile).
    exec "$@"

    ```
- SQL file for resetting the database password (tmp/sqlinit.sql)
    ```
    use mysql;
    update user set password=PASSWORD("chinmay2002") where User='root';
    flush privileges;
    ```