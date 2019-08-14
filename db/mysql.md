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

#### mysql锁

手动加锁指的是对SELECT语句加锁，UPDATE语句始终都会自动加锁，是串行执行的，不需要考虑。

比如下面sql:

```sql
#transaction1
UPDATE table_name SET num=num+1 WHERE num=0;
```

```
#transaction2
UPDATE table_name SET num=num+1 WHERE num=0;
```

上面两条SQL始终都是串行执行的，所以只要UPDATE语句写成类似 “SET x=x+n” 正确就不会有问题。


当有些SQL不能使用 “SET x=x+n” 这种方式时，才需要考虑:

```
SELECT ... LOCK IN SHARE MODE;

SELECT ... FOR UPDATE;
```

#### 共享锁(Share Lock)

共享锁又称读锁，是读取操作创建的锁。其他用户可以并发读取数据，但任何事务都不能对数据进行修改（获取数据上的排他锁），直到已释放所有共享锁。

如果事务T对数据A加上共享锁后，则其他事务只能对A再加共享锁，不能加排他锁。获准共享锁的事务只能读数据，不能修改数据。

用法
SELECT ... LOCK IN SHARE MODE;

在查询语句后面增加LOCK IN SHARE MODE，Mysql会对查询结果中的每行都加共享锁，当没有其他线程对查询结果集中的任何一行使用排他锁时，可以成功申请共享锁，否则会被阻塞。其他线程也可以读取使用了共享锁的表，而且这些线程读取的是同一个版本的数据。


#### 排他锁（eXclusive Lock）

排他锁又称写锁，如果事务T对数据A加上排他锁后，则其他事务不能再对A加任任何类型的封锁。获准排他锁的事务既能读数据，又能修改数据。
     
用法
SELECT ... FOR UPDATE;
     
在查询语句后面增加FOR UPDATE，Mysql会对查询结果中的每行都加排他锁，当没有其他线程对查询结果集中的任何一行使用排他锁时，可以成功申请排他锁，否则会被阻塞。