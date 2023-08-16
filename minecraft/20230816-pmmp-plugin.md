# Pmmp插件互相信赖问题
> 插件可以使用phar注入方式 注入到另一个phar包中 可以自动加载

By the way, if you want to use InvMenu in your plugin that's in .phar format, you can run the following:
Code:

```
bin/php7/bin/php virions/InvMenu.phar /path/to/your/plugin.phar
```

That will inject the InvMenu virion into your phar plugin.

> https://forums.pmmp.io/threads/invmenu.7303/