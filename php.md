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