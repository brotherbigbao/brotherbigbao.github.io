# PHP

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