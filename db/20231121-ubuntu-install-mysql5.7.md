# ubuntu install MySQL5.7
> Installing MySQL on Unix/Linux Using Generic Binaries

- [MySQL官方文档](https://dev.mysql.com/doc/refman/5.7/en/binary-installation.html)
- [官方下载链接](https://downloads.mysql.com/archives/community/)
- [中文说明 CSDN blog](https://blog.csdn.net/javaanddonet/article/details/113277953)



Table 2.3 MySQL Installation Layout for Generic Unix/Linux Binary Package

| Directory | Contents of Directory |
| ---- | ---- |
|bin	|mysqld server, client and utility programs|
|docs	|MySQL manual in Info format|
|man	|Unix manual pages|
|include	|Include (header) files|
|lib	|Libraries|
|share	|Error messages, dictionary, and SQL for database installation|
|support-files	|Miscellaneous support files|

```
$> groupadd mysql
$> useradd -r -g mysql -s /bin/false mysql
$> cd /usr/local
$> tar zxvf /path/to/mysql-VERSION-OS.tar.gz
$> ln -s full-path-to-mysql-VERSION-OS mysql
$> cd mysql
$> mkdir mysql-files
$> chown mysql:mysql mysql-files
$> chmod 750 mysql-files
$> bin/mysqld --initialize --user=mysql
$> bin/mysql_ssl_rsa_setup
$> bin/mysqld_safe --user=mysql &
# Next command is optional
$> cp support-files/mysql.server /etc/init.d/mysql.server
```

cp support-files/mysql.server /etc/init.d/mysql.server  作用是重启后可以使用 systemctl status mysql 等命令方便启停

![Visitor Count](https://profile-counter.glitch.me/liuyibao/count.svg)