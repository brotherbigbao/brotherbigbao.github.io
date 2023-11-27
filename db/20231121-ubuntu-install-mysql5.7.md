# ubuntu install MySQL5.7 (直接下载二进制文件安装)
> Installing MySQL on Unix/Linux Using Generic Binaries

- [MySQL官方文档](https://dev.mysql.com/doc/refman/5.7/en/binary-installation.html)
- [官方下载链接](https://downloads.mysql.com/archives/community/)
- [中文说明 CSDN blog](https://blog.csdn.net/javaanddonet/article/details/113277953)

- [通过APT安装旧版本MySQL 实测Ubuntu22.04无法选择mysql5.7 已放弃](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/)


## 安装

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

## 增加配置文件 (默认没有配置文件)

sudo vim /etc/my.cnf

为了解决默认 datetime 格式不能保存 '0000-00-00 00:00:00', 输入以下内容并保存重启mysql

```
[mysqld]

sql_mode=ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
```

## 问题 SELECT list is not in GROUP BY clause and contains nonaggregated column

SELECT list 必须在查询列表中解决

去除 ONLY_FULL_GROUP_BY