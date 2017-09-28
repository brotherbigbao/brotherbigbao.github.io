# MyBatis

## xml数据类型

由于数据库区分 date time datetime 类型，但是 Java 中一般都使用 java.util.Date
类型。 因此为了保证数据类型的正确，需要手动指定日期类型， date、time、datetime
对应的 JDBC 类型分别为 DATE、TIME、TIMESTAMP