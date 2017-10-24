## homebrew 操作指南

##### php56 php71共存问题

1. brew install php56; brew install php71 
2. 更改php71 fpm配置端口号到9001
3. brew services start php56; brew services start php71
4. 切换命令行到php56: brew unlink php71; brew link php56;
5. 执行发现报jpeg依赖错误, 原因是php71使用的是9b版本, php56使用的是8d版本，brew info jpeg发现目前两个版本都存在，brew switch jpeg 8d即可运行php
6. [Stackoverflow](https://stackoverflow.com/questions/32703296/dyld-library-not-loaded-usr-local-lib-libjpeg-8-dylib-homebrew-php)



##### php多版本共存
**PHP Installation**
> We will proceed by installing PHP 5.6, PHP 7.0, PHP 7.1 and PHP 7.2 and using a simple script to switch between them as we need.

You can get a full list of available options to include by typing brew options php56, for example. In this example we are just including Apache support via --with-httpd to build the required PHP modules for Apache.
```
$ brew install php56 --with-httpd
$ brew unlink php56
$ brew install php70 --with-httpd
$ brew unlink php70
$ brew install php71 --with-httpd
$ brew unlink php71
$ brew install php72 --with-httpd
```
This may take some time as your computer is actually compiling PHP from source.

> You must reinstall each PHP version with reinstall command rather than install if you have previously installed PHP through Brew.
Also, you may have the need to tweak configuration settings of PHP to your needs. A common thing to change is the memory setting, or the date.timezone configuration. The php.ini files for each version of PHP are located in the following directories:

```
/usr/local/etc/php/5.6/php.ini
/usr/local/etc/php/7.0/php.ini
/usr/local/etc/php/7.1/php.ini
/usr/local/etc/php/7.2/php.ini
```
You can install as many or as few PHP versions as you like, it's nice to have options right?
Let's switch back to the first PHP version now:

```
$ brew unlink php72
$ brew link php56
```

[原文在此](https://getgrav.org/blog/macos-sierra-apache-multiple-php-versions)