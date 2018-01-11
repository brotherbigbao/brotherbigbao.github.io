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