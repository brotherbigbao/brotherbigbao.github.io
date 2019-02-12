### 日期格式

日期格式最好使用ISO 8601标准， PHP中是 date('c', $dateString);

> https://www.elastic.co/guide/en/elasticsearch/reference/2.4/date.html
> http://php.net/manual/en/function.date.php

### docker配置相关

- 需要配置的volume, 这个目录保存的是索引数据:

```
/usr/share/elasticsearch/data
```
 

- 需要自定义配置时:

```
-v full_path_to/custom_elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
```

> https://www.elastic.co/guide/en/elasticsearch/reference/6.7/docker.html

### 请求体结构化查询要点

1.bool下只能是must,must_not,should中的一个或多个

```
bool 过滤
bool 过滤可以用来合并多个过滤条件查询结果的布尔逻辑，它包含一下操作符：

must :: 多个查询条件的完全匹配,相当于 and。
must_not :: 多个查询条件的相反匹配，相当于 not。
should :: 至少有一个查询条件匹配, 相当于 or。
这些参数可以分别继承一个过滤条件或者一个过滤条件的数组：

{ 
    "bool": { 
        "must":     { "term": { "folder": "inbox" }}, 
        "must_not": { "term": { "tag":    "spam"  }}, 
        "should": [ 
                    { "term": { "starred": true   }}, 
                    { "term": { "unread":  true   }} 
        ] 
    } 
}
```

2.must,must_not,should下面套term,terms,range,match,wildcard等

3.query,filter同时查询必须放到filtered下面, 示例

```json
{
  "query": {
    "filtered": {
      "query": {
        "bool": {
          "should": [
            {"wildcard": { "mobile": "*159006*"}},
            {"wildcard": {"nickname": "*159006*"}},
            {"match_phrase": {"nickname": "*159006*"}},
            {"wildcard": {"card_number": "*1590061*"}}
          ]
        }
      },
      "filter": {
        "bool": {
          "must": [
            { "term": {"uid": "876426"}},
            { "term": {"status": 1}}
          ]
        }
      }
    }
  },
  "size": 10,
  "from": 0,
  "sort": [
    {"id": {"order": "desc"}},
    {"status": {"order": "desc"}}
  ]
}
```