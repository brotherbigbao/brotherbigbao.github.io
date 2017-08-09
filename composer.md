## composer日常使用

##### 全局更改
```
composer config -g repo.packagist composer https://packagist.phpcomposer.com
```

##### 项目内更改
```
composer config repo.packagist composer https://packagist.phpcomposer.com
```

##### Composer版本符号
[https://getcomposer.org/doc/articles/versions.md](https://getcomposer.org/doc/articles/versions.md)

#### Composer安装指定版本laravel
```
composer create-project --prefer-dist laravel/laravel blog "5.1.*"
```

#### 安装器安装laravel
```
composer global require "laravel/installer"
laravel new blog
```