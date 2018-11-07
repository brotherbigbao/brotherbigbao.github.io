# PHP

#### PHP作为WEB服务重要的预定义变更 

$_SERVER['REQUEST_URI'] 

The URI which was given in order to access this page; for instance, '/index.html'.

现在主流框架是使用这个参数匹配路由，此参数从nginx传过来，是最原始请求url, 不能被修改

在Nginx中, $request_uri 这个变量等于包含一些客户端请求参数的原始URI，它无法修改，请查看$uri更改或重写URI，不包含主机名，例如：”/cnphp/test.php?arg=freemouse”

```
在nginx中以下配置

location / {
    try_files $uri $uri/ /index.php?$query_string;
    index index.php index.html index.htm;
}

假如请求的url是: /m/blog/342432432?from=baidu

经过try_files会被转为: /index.php?from=baidu

此时的url会被下面的location匹配发送给php-fpm, 这时就明白为什么用 \.php$ 能够匹配到

location ~ \.php$ {
    include fastcgi-php.conf;
    fastcgi_pass   php-fpm:9000;
}

现在再看NGINX配置

fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
fastcgi_param  QUERY_STRING       $query_string;
fastcgi_param  REQUEST_METHOD     $request_method;
fastcgi_param  CONTENT_TYPE       $content_type;
fastcgi_param  CONTENT_LENGTH     $content_length;

fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
fastcgi_param  REQUEST_URI        $request_uri;
fastcgi_param  DOCUMENT_URI       $document_uri;
fastcgi_param  DOCUMENT_ROOT      $document_root;
fastcgi_param  SERVER_PROTOCOL    $server_protocol;
fastcgi_param  REQUEST_SCHEME     $scheme;
fastcgi_param  HTTPS              $https if_not_empty;

fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;

fastcgi_param  REMOTE_ADDR        $remote_addr;
fastcgi_param  REMOTE_PORT        $remote_port;
fastcgi_param  SERVER_ADDR        $server_addr;
fastcgi_param  SERVER_PORT        $server_port;
fastcgi_param  SERVER_NAME        $server_name;

# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param  REDIRECT_STATUS    200;

$request_uri被传给PHP的$_SERVER['REQUEST_URI'], 这个值仍然是 /m/blog/342432432?from=baidu

PHP框架可以用这个原始值解析路由，$request_uri不会因为try_files等命令被更改，这个是请求原始值。

老早研究过的，差点忘了，记下来
```

#### Laravel 5.6 Will Remove the Artisan Optimize Command
With recent improvements to PHP op-code caching, the optimize Artisan command is no longer needed.

composer 会判断假如>5.6会使用静态加载,opcache会有效缓存
```php
// vendor/composer/autoload_real.php
$useStaticLoader = PHP_VERSION_ID >= 50600 && !defined('HHVM_VERSION') && (!function_exists('zend_loader_file_encoded') || !zend_loader_file_encoded());
```
> [Laravel 5.6 Will Remove the Artisan Optimize Command](https://laravel-news.com/laravel-5-6-removes-artisan-optimize)
> [Speeding-up autoloading on PHP 5.6 & 7.0+ for everyone](https://blog.blackfire.io/speeding-up-autoloading-on-php-5-6-7-0-for-everyone.html)

#### 编译github php-src
```
./buildconf  #生成configure
./configure  
make && make install
```

#### function arguments passing by reference and values
> http://php.net/manual/en/functions.arguments.php

```php
function sum($array,$max){   //For Reference, use:  "&$array"
    $sum=0;
    for ($i=0; $i<2; $i++){
        #$array[$i]++;        //Uncomment this line to modify the array within the function.
        $sum += $array[$i];  
    }
    return ($sum);
}

$max = 1E7                  //10 M data points.
$data = range(0,$max,1);

$start = microtime(true);
for ($x = 0 ; $x < 100; $x++){
    $sum = sum($data, $max);
}
$end =  microtime(true);
echo "Time: ".($end - $start)." s\n";

/* Run times:
#    PASS BY    MODIFIED?   Time
-    -------    ---------   ----
1    value      no          56 us
2    reference  no          58 us

3    valuue     yes         129 s
4    reference  yes         66 us
```

Conclusions:

1. PHP is already smart about zero-copy / copy-on-write. A function call does NOT copy the data unless it needs to; the data is
   only copied on write. That's why  #1 and #2 take similar times, whereas #3 takes 2 million times longer than #4.
   [You never need to use &$array to ask the compiler to do a zero-copy optimisation; it can work that out for itself.]

2. You do use &$array  to tell the compiler "it is OK for the function to over-write my argument in place, I don't need the original
   any more." This can make a huge difference to performance when we have large amounts of memory to copy.
   (This is the only way it is done in C, arrays are always passed as pointers)

3. The other use of & is as a way to specify where data should be *returned*. (e.g. as used by exec() ).
   (This is a C-like way of passing pointers for outputs, whereas PHP functions normally return complex types, or multiple answers
   in an array)

4. It's  unhelpful that only the function definition has &. The caller should have it, at least as syntactic sugar. Otherwise
   it leads to unreadable code: because the person reading the function call doesn't expect it to pass by reference. At the moment,
   it's necessary to write a by-reference function call with a comment, thus:
    $sum = sum($data,$max);  //warning, $data passed by reference, and may be modified.

5. Sometimes, pass by reference could be at the choice of the caller, NOT the function definitition. PHP doesn't allow it, but it
   would be meaningful for the caller to decide to pass data in as a reference. i.e. "I'm done with the variable, it's OK to stomp
   on it in memory".
   
   
#### null值取下标不会报错, 但最好不要这么干, php5 php7都是这样

```php
$a = null;
echo $a['name']; //不会报错

$b = [];
echo $b['name']; //会报notice
```


#### PHP Fatal error: Cannot use Foo\Bar as Bar because the name is already in use

```
/*
 * Example:
 */

// in src/Model/Entity/Foo.php
namespace Model\Entity;

class Foo {
}

// in src/Model/Service/Foo.php
namespace Model\Service;

class Foo {
}

// in src/Model/Service/Bar.php
namespace Model\Service;

use Model\Entity\Foo; // raises fatal error with phpunit

class Bar {
}
This code is executable by PHP. PHP seems to prefer the use statement in src/Model/Service/Bar.php, but PHPUnit code coverage evaluates namespace first.
```

```
You need to alias use Model\Entity\Foo; when you import it because it conflicts with an exisiting class. The only reason you might not see the error in php is if that other class hasn't been autoloaded yet.
```

[原始连接https://github.com/sebastianbergmann/php-code-coverage/issues/383#issuecomment-139998575](https://github.com/sebastianbergmann/php-code-coverage/issues/383#issuecomment-139998575)

> PHP7.0下测试不会报错, 5.6会报错, 应该是PHP的Bug


#### 十个 PHP 开发者最容易犯的错误

- [十个 PHP 开发者最容易犯的错误](https://laravel-china.org/topics/9104/the-most-easy-mistakes-made-by-ten-php-developers)
- [Buggy PHP Code: The 10 Most Common Mistakes PHP Developers Make](https://www.toptal.com/php/10-most-common-mistakes-php-programmers-make)
