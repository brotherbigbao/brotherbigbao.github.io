## homebrew 操作指南

##### php56 php71共存问题

1. brew install php56; brew install php71 
2. 更改php71 fpm配置端口号到9001
3. brew services start php56; brew services start php71
4. 切换命令行到php56: brew unlink php71; brew link php56;
5. 执行发现报jpeg依赖错误, 原因是php71使用的是9b版本, php56使用的是8d版本，brew info jpeg发现目前两个版本都存在，brew switch jpeg 8d即可运行php
6. [Stackoverflow](https://stackoverflow.com/questions/32703296/dyld-library-not-loaded-usr-local-lib-libjpeg-8-dylib-homebrew-php)
