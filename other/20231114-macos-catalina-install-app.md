# “Parallels Desktop” 已损坏，无法打开。您应该推出磁盘映像。处理办法
> 当软件无法安装时处理方案，在Catlina测试

## 设置安全与隐私勾选任何来源

```
sudo spctl --master-disable
```

执行后在安全性与隐私中打开。

## 将dmg安装包的内容 copy 到磁盘中，并对文件执行下面操作

按快捷键 shift + command + . 显示隐藏文件

找到隐藏的"Parallels Desktop.app"文件路径

执行下面命令：

```
sudo xattr -r -d com.apple.quarantine ~/Desktop/Parallels\ Desktop.app
```

## 重新打包成dmg

打开 "磁盘工具"

"文件" -> "新建映像" -> "来自文件夹的映像"

打包完之后就可以用这个dmg安装了。 注意目前只在Catalina下测试，更高版本不一定有用

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)