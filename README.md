# IRIS-Systems-Task

### Task 5
Enable persistence for the DB data and Nginx config files so that they are available even when the containers go down.

- docker-compose
  ```
    app1:
    ...
        volumes:
        - ./Shopping-App-IRIS:/Shopping-App-IRIS
    ...
    app2:
    ...
        volumes:
        - ./Shopping-App-IRIS:/Shopping-App-IRIS
    ...
    app3:
    ...
        volumes:
        - ./Shopping-App-IRIS:/Shopping-App-IRIS
    ...
    db:
    ...
        volumes:
        - ./databasebackup/data:/var/lib/mysql
    ...
    nginx:
    ... 
        volumes: 
        - ./nginx/nginx.conf:/etc/nginx/nginx.conf
    ...
    ```
    Volume mounts used for mysql container which backs up the data when a container is stopped, so that the user can sign in without signing up again when the container is restarted. Volume mount used for nginx container also which makes it sensitive to changes made to the config files when container is up so that it is reflected when container is restarted.


 
