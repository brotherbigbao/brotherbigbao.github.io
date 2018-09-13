#### Mysql5.6系统变量
[dev.mysql.com](https://dev.mysql.com/doc/refman/5.6/en/server-system-variables.html)

#### 显示所有系统变量状态
```
SHOW VARIABLES;
SHOW GLOBAL VARIABLES;
```

#### 相关参数慢日志
```sql
SHOW GLOBAL VARIABLES LIKE 'slow_query_log';
SHOW GLOBAL VARIABLES LIKE 'long_query_time';
SHOW GLOBAL VARIABLES LIKE 'slow-query-log-file';


-- SET GLOBAL slow_query_log=1;
-- SET GLOBAL long_query_time=0;
```

#### 统计table数量
```
USE databasename; SHOW TABLES; SELECT FOUND_ROWS();
```

#### CURRENT_TIMESTAMP

在5.5到5.6.4版本里，对于DEFAULT CURRENT_TIMESTAMP子句，只能TIMESTAMP类型列上指定。

而从5.6.5开始（也包括5.7），DEFAULT CURRENT_TIMESTAMP子句可以指定到TIMESTAMP或者DATETIME类型列上。

比如在5.5中:

```sql
mysql> select version();
+------------+
| version()  |
+------------+
| 5.5.48-log |
+------------+
1 row in set (0.00 sec)
```

#### MYSQL INNODB 回滚

插入一条数据，然后回滚，自增主键不会回滚

所以当跨库插入数据的时候, 假如两个库的数据使用同一主键，虽然异常回滚并不能回滚另一个库的数据，但是不影响下一次数据的写入

php mysql_connect当参数与上次一致时会重用上一个连接，pdo则不会重用连接(在php5.6.35 Yii2.0中测试是这样的)


#### mysql常用命令

1.导出, innodb格式最好使用--single-transaction, 防止锁表

```sql
mysqldump -h $host -u $username --password --databases $db_name --tables $table_name --single-transaction > ./dump.sql
```

2.导入

```sql
mysqlimport -h $host -u $username -p $db_name import.sql
```