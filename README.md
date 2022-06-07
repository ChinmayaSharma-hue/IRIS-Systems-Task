# IRIS-Systems-Task

### Task 2
Launch the application in a docker container. Launch a separate container for the database and ensure that the two containers are able to connect.
1. The DB port should not be exposed to the host or external network. It must be internal to the docker network only.
2. Expose the application port to the host machine at 8080. So you should be able to access the app at “localhost:8080”.

- docker-compose
  ```
    version: '3.8'

    services:
    db:
        image: mysql:5.7
        restart: always
        environment:
        - MYSQL_ROOT_PASSWORD=password
        - MYSQL_DATABASE=app
        - MYSQL_USER=user
        - MYSQL_PASSWORD=password
        expose:
        - '3306'
        volumes:
        - ./databasebackup/data:/var/lib/mysql
    app:
        build: ./Shopping-App-IRIS
        # command: bash -c "rm -f tmp/pids/server.pid && bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rails s -p 3000 -b '0.0.0.0'"
        ports:
        - "8080:3000"
        volumes:
        - ./Shopping-App-IRIS:/Shopping-App-IRIS
        depends_on:
        - db
        links:
        - db
        environment:
        - DB_USER=root
        - DB_NAME=app
        - DB_PASSWORD=password
        - DB_HOST=db
  ```
- database.yml
    ```
    default: &default
    adapter: mysql2
    encoding: utf8
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    database: <%= ENV['DB_NAME'] %>
    username: <%= ENV['DB_USER'] %>
    password: <%= ENV['DB_PASSWORD'] %>
    host: <%= ENV['DB_HOST'] %>
    socket: /var/run/mysqld/mysqld.sock

    development:
    <<: *default

    test:
    <<: *default

    production:
    <<: *default

    ```
- Modified Entrypoint file
    ```
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

    ```
    Resetting the password is not needed in the application container anymore as the database container is a separate container, with the password sent in the environment variables. <br>
- Running Containers,
![image](https://user-images.githubusercontent.com/76653568/172456510-eaead038-9235-4335-8135-b42421b4553c.png)<br>
![image](https://user-images.githubusercontent.com/76653568/172456358-5a63d36b-0765-40fa-92b6-d432947ba012.png)<br><br>
- Site available at port 8080,
  ![image](https://user-images.githubusercontent.com/76653568/172460315-0f966092-13c0-464b-96cf-33d32f9bfaac.png)


