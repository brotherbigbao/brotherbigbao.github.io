# 关于Repository模式
> 为什么不使用ORM的关联或with查询

使用ORM的关联和with在初期开发时可以减少不少工作量，但是后期维护或重构成本巨大，比如更改数据表、字段、拆表等，相关查询的修改将会遍布整个项目。

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)