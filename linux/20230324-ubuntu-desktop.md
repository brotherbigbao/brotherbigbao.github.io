# ubuntu desktop 作为开发机的一些操作
> ubuntu desktop 作为开发机的一些操作

# 安装指定php环境

```
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.1
```

# 禁用apache2

```
sudo systemctl stop apache2.service
sudo systemctl disable apache2.service
```

# idea编辑器中文输入法问题修复

> https://cloud.tencent.com/developer/article/1929886

在idea打开页面

- 点击 help
- 点击Edit Custom VM options
- 在末行添加： -Drecreate.x11.input.method=true

```
-XX:ReservedCodeCacheSize=512m
-Xmx2048m
-Xms128m
-XX:+UseG1GC
-XX:SoftRefLRUPolicyMSPerMB=50
-XX:CICompilerCount=2
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-ea
-Dsun.io.useCanonCaches=false
-Djdk.http.auth.tunneling.disabledSchemes=""
-Djdk.attach.allowAttachSelf=true
-Djdk.module.illegalAccess.silent=true
-Dkotlinx.coroutines.debug=off
-Dsun.tools.attach.tmp.only=true

-Drecreate.x11.input.method=true
```