## laravel日常使用

##### laravel安装器
```
composer global require "laravel/installer"
laravel new blog
```

##### composer create-project
```
composer create-project laravel/laravel your-project-name --prefer-dist "5.1.*"
```


##### 查询构造器 Illuminate\Database\Eloquent\Model::newQuery()
```$xslt
$builder = $this->trailer->newQuery();
foreach($movieCollection as $key=>$obj) {
    if ($key > 0) {
        $builder->orWhere([
            ['provider_id', '=', $obj->provider_id],
            ['provider_movie_id', '=', $obj->provider_movie_id],
        ]);
    } else {
        $builder->where([
            ['provider_id', '=', $obj->provider_id],
            ['provider_movie_id', '=', $obj->provider_movie_id],
        ]);
    }
}
$trailerCollection = $builder->get();
```


##### 打印SQL
```
class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        DB::listen(function($sql, $bindings, $time) {
            echo $sql, "\n";
            print_r($bindings);
            echo $time, "\n";
        });
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
```