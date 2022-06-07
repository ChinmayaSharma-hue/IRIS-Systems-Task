# IRIS-Systems-Task

### Task 3
Launch an Nginx container, and configure it as a reverse proxy to the rails application. Expose it at port 8080 on localhost. So now the rails application shouldn’t be accessed directly. All requests will go through Nginx.


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
        nginx:
            image: nginx:latest
            depends_on:
            - app
            - db
            ports:
            - '8080:8080'
            links:
            - app
            volumes:
            - ./revprx/nginx.conf:/etc/nginx/nginx.conf
            restart: always
  ```
- nginx configuration file, nginx.conf
    ```
    user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    include /etc/nginx/modules-enabled/*.conf;

    events {}
    http {
        server {
            listen 8080;
            server_name localhost 127.0.0.1;
            location / {
                proxy_pass  http://app:3000;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
            }
        }
    }
    ```
 