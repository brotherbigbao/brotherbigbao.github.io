# Jetbrains 系列 IDE 配置 no-index
> Jetbrains 系列 IDE 配置

## 2021.2.3 以下版本

ide-eval-resetter 插件

## 2021.2.3 及以上版本

```
#Custom VM Options

-javaagent:/home/liuyibao/Application/ja-netfilter-V2023/ja-netfilter.jar=jetbrains
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
```