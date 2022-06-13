# IRIS-Systems-Task

### Task 8
Create a cron job to create nightly database dumps and store them on the host machine for persistence.

A docker image for running a cron job by connecting to the database container exists, which can be included in `docker-compose.yml`.
```
version: '3.8'

services:
  mysql-cron-backup:
    image: fradelg/mysql-cron-backup
    depends_on:
      - db
    volumes:
      - ./databasebackup:/backup
    environment:
      - MYSQL_HOST=db
      - MYSQL_USER=root
      - MYSQL_PASS=password
      - MAX_BACKUPS=15
      - INIT_BACKUP=0
      # Every day at 00:00
      - CRON_TIME=0 0 * * *
      # Make it small
      - GZIP_LEVEL=9
    restart: unless-stopped
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
      - DB_PASSWORD=chinmay2002
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
      - DB_PASSWORD=chinmay2002
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
      - DB_PASSWORD=chinmay2002
      - DB_HOST=db
    restart: always
  db:
    image: mysql:5.7
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=chinmay2002
      - MYSQL_DATABASE=app
      - MYSQL_USER=user
      - MYSQL_PASSWORD=chinmay2002
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

where 0 0 * * * means that the cronjob is going to be executed at 00:00 hours every day (at midnight).

After building and running all the containers,
![image](https://user-images.githubusercontent.com/76653568/173368826-fbde9852-782d-42a6-bc33-fe72359d2fce.png)
![image](https://user-images.githubusercontent.com/76653568/173368901-3343dd58-c486-4eca-a96c-2c92f5a5a8ea.png)


