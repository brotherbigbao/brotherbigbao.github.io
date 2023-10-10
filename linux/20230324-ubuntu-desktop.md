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

# idea 键盘插件 使用Ctrl键替换command键 (idea 官方插件是meta键 需要配合 gnome-tweaks，使用起来还有问题)

macOS For All

> https://plugins.jetbrains.com/plugin/13968-macos-for-all

> https://github.com/samvtran/jetbrains-macos-keybindings-for-all

# gitlab 使用sha1报错

sign_and_send_pubkey: no mutual signature supported

新建 ~/.ssh/config 文件，插入如下内容:

```
PubkeyAcceptedKeyTypes +ssh-rsa
```

# 开启SSH Server

```
sudo apt install openssh-server
sudo systemctl status ssh

如果没有启用则: sudo systemctl enable --now ssh

```

# gnome-tweaks 更改键盘映射 中文名：优化 安装好后会自动放在工具文件夹下

在ubuntu应用商店就可以搜索安装

或者在命令行安装: sudo apt install gnome-tweaks

然后交换左win 和 左 ctrl 位置

```
or Ubuntu 20.04, you should relace the command (aka. Windows/ Win) key with the meta key.

Run sudo apt install gnome-tweaks
Run gnome-tweaks
Click Keyboard & Mouse > Additional Layout Options > Expand Alt/Win key behaviour > Select "Meta is mapped to Win" (2nd last in list)
```

> https://askubuntu.com/questions/604496/using-mac-os-shortcuts-in-intellij-idea-with-ubuntu

> https://www.cnblogs.com/liuzhch1/p/16047019.html

![Visitor Count](https://profile-counter.glitch.me/liuyibao/count.svg)