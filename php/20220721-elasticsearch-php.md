# PHP 中正确使用 Elasticsearch
> 正确使用 elasticsearch 官方 php sdk


## sdk中定义的可能抛出哪些异常

```
if ($statusCode === 400 && strpos($responseBody, "AlreadyExpiredException") !== false) {
    $exception = new AlreadyExpiredException($responseBody, $statusCode);
} elseif ($statusCode === 403) {
    $exception = new Forbidden403Exception($responseBody, $statusCode);
} elseif ($statusCode === 404) {
    $exception = new Missing404Exception($responseBody, $statusCode);
} elseif ($statusCode === 409) {
    $exception = new Conflict409Exception($responseBody, $statusCode);
} elseif ($statusCode === 400 && strpos($responseBody, 'script_lang not supported') !== false) {
    $exception = new ScriptLangNotSupportedException($responseBody. $statusCode);
} elseif ($statusCode === 408) {
    $exception = new RequestTimeout408Exception($responseBody, $statusCode);
} else {
    $exception = new BadRequest400Exception($responseBody, $statusCode);
}
```


假如想忽略异常（比如create时已经存在document，没有查询到文档）可以类似这样做：

```
$params = [
    'index'  => 'test_missing',
    'type'   => 'test',
    'id'     => 1,
    'client' => [ 'ignore' => 404 ] 
];
echo $client->get($params);
```

404：不存在
409: create或index指定版本号时，冲突

- [忽略异常](https://www.elastic.co/guide/en/elasticsearch/client/php-api/6.x/_ignoring_exceptions.html)
- [忽略异常](https://www.elastic.co/guide/cn/elasticsearch/guide/current/create-doc.html)