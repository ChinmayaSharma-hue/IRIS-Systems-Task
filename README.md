# IRIS-Systems-Task

### Task 8
Create a cron job to create nightly database dumps and store them on the host machine for persistence.

In the host machine, create a crontab.
```
0 0 * * * root docker-compose -f /home/Chimnay/DockerSysTask/docker-compose.yml exec db bash -c 'mysqldump -p$MYSQL_ROOT_PASSWORD --all-databases' > "/home/Chimnay/DockerSysTask/databasebackup/backup_$(date + "%d_%m_%Y")"
```
where 0 0 * * * means that the cronjob is going to be executed at 00:00 hours every day (at midnight).
The docker-compose exec allows running commands inside the container specified, in this case, the `db` container where the `mysqldump` command allows to dump the data into the host machine every night.

- ![image](https://user-images.githubusercontent.com/76653568/173197500-6caa0fbe-e344-4835-9018-6037fe76fb6d.png)

