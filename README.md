# IRIS-Systems-Task

### Task 4
Now launch two more containers of the rails application. All three containers should be able to connect to a single database container. Configure Nginx container to load balance incoming requests between the three containers.

- docker-compose
  ```
    version: '3.8'

    services:
    app1:
        build: ./Shopping-App-IRIS
        expose:
        - '3000'
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
        restart: always
    app2:
        build: ./Shopping-App-IRIS
        expose:
        - '3000'
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
        restart: always
    app3:
        build: ./Shopping-App-IRIS
        expose:
        - '3000'
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
        restart: always
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
    nginx:
        image: nginx:latest
        depends_on:
        - app1
        - app2
        - app3
        - db
        ports:
        - '8080:8080'
        links:
        - app1
        - app2
        - app3
        volumes:
        - ./nginx/nginx.conf:/etc/nginx/nginx.conf
        restart: always  
    ```
- nginx configuration file, nginx.conf
    Using the Round-Robin Load balancing (equal distribution of requests among the servers)
    ```
    user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    include /etc/nginx/modules-enabled/*.conf;

    events {}
    http {
        upstream backend {
            server app1:3000 weight=1;
            server app2:3000 weight=1;
            server app3:3000 weight=1;
        }
        server {
            listen 8080;
            server_name localhost 127.0.0.1;
            location / {
                proxy_pass  http://backend;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
            }
        }
    }
    ```
 