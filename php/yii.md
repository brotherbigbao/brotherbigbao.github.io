## 数据库查询

- 当查询的列指定了别名或是count, sum等查询时，一定要加上asArray(), 不然数据映射不到Orm的属性里， 只有数据表存在的名字才会被映射到orm里。

```php
'coach_id','count(*) as class_number','sum(apply_number) as total_apply_number'
类似这个查询只有coach_id映射到属性里，遍历的时候只有coach_id这个属性， 直接返回数组就不存在这个问题
```