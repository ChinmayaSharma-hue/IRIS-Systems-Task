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
      - MYSQL_PASS=chinmay2002
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
<<<<<<< HEAD
After building and running all the docker containers,
=======
where 0 0 * * * means that the cronjob is going to be executed at 00:00 hours every day (at midnight).
The docker-compose exec allows running commands inside the container specified, in this case, the `db` container where the `mysqldump` command allows to dump the data into the host machine every night.

![image](https://user-images.githubusercontent.com/76653568/173197500-6caa0fbe-e344-4835-9018-6037fe76fb6d.png)
>>>>>>> a73e9eaa2dc6cc43ead6d05c7181bfcfd805b550

