# Linux Ubuntu22.04 Android模拟器 麟卓卓懿
> 安装后无法打开解决

# 安装无法打开

准备卸载时发现报错 qt.qpa.plugin:Could not load the Qt platform plugin "xcb"

网上搜索发现安装这个依赖就可以

```
sudo apt install libxcb-xinerama0
```

项目安装目录在： /opt/xdroid/

卸载脚本：/opt/xdroid/uninstall

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)