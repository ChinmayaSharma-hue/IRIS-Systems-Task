use mysql;
update user set password=PASSWORD("password") where User='root';
flush privileges;
