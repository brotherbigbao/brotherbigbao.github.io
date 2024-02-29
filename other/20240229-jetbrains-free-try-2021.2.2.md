# jetbrains idea phpstorm pycharm free try 2021.2.2及以下版本
> jetbrains idea 2021.2.2及以下版本免费试用

pycharm 2021.2.2 版本之前试用期过了怎么办

虽然 jetbrains 的产品是商业收费，而且价格不菲，但官方还是为免费使用留下的空间，实在良心。 收费版可以免费试用30天，问题是30天试用期过后，怎么办，可以再次试用吗？👉

安装 eval reset 插件实现自动延期

pycharm 和 idea 有免费版，其他产品没有。可以使用收费版，选择30天免费试用期，过期后，删除试用的授权文件，重新申请试用，这个过程无须联网，手工操作或者使用 IDE eval reset 插件都可以。

手工删除试用授权后重新试用

但有时，因为隔了太长一段时间没有打开过 ide，eval reset 插件 没有自动重置试用日期，因过期无法进入程序，此时无法再通过选择 “evaluate for free” 来重新试用，那么可以通过手动删除试用授权文件的方法来解决。

试用授权文件位于程序配置目录下的 eval 文件夹。

- windows：%userprofile%/AppData/Roaming/JetBrains/产品名版本号
- macos: ~/Library/ApplicationSupport/JetBrains/产品名版本号
- linux: ~/.config/JetBrains/产品名版本号

将程序配置路径下的 eval 文件夹 重命名或者删除后，重启程序即可。

原文链接：[csdn](https://blog.csdn.net/qq_34445574/article/details/130215761)

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)