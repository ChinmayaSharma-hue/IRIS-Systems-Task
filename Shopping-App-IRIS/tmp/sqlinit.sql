use mysql;
update user set password=PASSWORD("chinmay2002") where User='root';
flush privileges;
