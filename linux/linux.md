##### 以另一用户身份执行命令
```
su - git -c /data/website/gogs/gogs web
```

##### su 与 su - 区别
- su 只是切换了root身份，但Shell环境仍然是普通用户的Shell
- su - 用户和Shell环境一起切换成root身份了。只有切换了Shell环境才不会出现PATH环境变量错误，应该使用此命令

##### 收藏链接
- [linux特殊文件权限SUID,SGID,SBIT](http://www.cnblogs.com/javaee6/p/4026108.html)
- [让进程在后台可靠运行的几种方法screen,nohup,&](https://www.ibm.com/developerworks/cn/linux/l-cn-nohup/index.html)

##### grep查询整个项目并输出文件路径行号
```
grep -rni '关键词' *
```

##### ubuntu安装automake, 会自动安装autoconf
```
apt install automake
```

##### ubuntu查看软件包依赖
```
apt-cache rdepends packagename
apt-cache showpkg <pkgname>
```
> [How to list dependent packages (reverse dependencies)](https://askubuntu.com/questions/128524/how-to-list-dependent-packages-reverse-dependencies)

```
apt-cache depends package-name
```
> [How can I check dependency list for a deb package](https://askubuntu.com/questions/80655/how-can-i-check-dependency-list-for-a-deb-package/80656)

##### ubuntu查看软件使用的源
```
apt-cache policy packagename
```

##### 建议使用apt
```
man 8 apt

apt provides a high-level commandline interface for the package management system. It is intended as an end user interface and enables
some options better suited for interactive usage by default compared to more specialized APT tools like apt-get(8) and apt-cache(8).

Much like apt itself, its manpage is intended as an end user interface and as such only mentions the most used commands and options
partly to not duplicate information in multiple places and partly to avoid overwhelming readers with a cornucopia of options and
details.
```

##### 生成ssh-key
```
ssh-keygen -t rsa
```

##### 生成openssl公私钥
```
openssl genrsa -out rsa_private_key.pem 1024
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
```

##### imagemagick
```
ls *.JPG | xargs -n1 -I {} convert -resize 800X600 {} {}
```

##### 查看指定PID的几种命令

```
top -p 10997
ps -ef | grep xxxx
ps -aux | grep xxxx
cat /proc/10997/status  #VmRSS是内存占比
```

> https://www.cnblogs.com/EasonJim/p/8040782.html

### crontab 命令详解

[IBM Knowledge Center, crontab](https://www.ibm.com/support/knowledgecenter/zh/ssw_aix_71/com.ibm.aix.cmds1/crontab.htm)


### crontab 导出文件和载入文件
```
crontab -l > /tmp/crontab.bak
echo 'something new...' >> /tmp/crontab.bak
crontab /tmp/crontab.bak
```

### ubuntu debian 软件包管理

```
dpkg -l //列出当前系统中所有的包.可以和参数less一起使用在分屏查看. (类似于rpm -qa)

dpkg -l |grep -i "软件包名" //查看系统中与"软件包名"相关联的包.

apt-cache policy xxxx
```

### man 命令

```
Linux提供了丰富的帮助手册，使用Linux man命令来查看一些不熟悉的命令的使用方法,还可以用来查询系统库文件中的一些函数定义和使用方法。

Linux man中的man就是manual的缩写，用来查看系统中自带的各种参考手册，但是手册页分为好几个部分，如下所示：

1   Executable programs or shell commands

2   System calls (functions provided by the kernel)

3   Library calls (functions within program libraries)

4   Special files (usually found in /dev)

5   File formats and conventions eg /etc/passwd

6   Games

7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)

8   System administration commands (usually only for root)

9   Kernel routines [Non standard]

----------------------

解释一下,

1是普通的命令

2是系统调用,如open,write之类的(通过这个，至少可以很方便的查到调用这个函数，需要加什么头文件)

3是库函数,如printf,fread

4是特殊文件,也就是/dev下的各种设备文件

5是指文件的格式,比如passwd,就会说明这个文件中各个字段的含义

6是给游戏留的,由各个游戏自己定义

7是附件还有一些变量,比如向environ这种全局变量在这里就有说明

8是系统管理用的命令,这些命令只能由root使用,如ifconfig

------------------------------------

n新文档，可能要移到更适合的领域。

o老文档，可能会在一段期限内保留。

l本地文档，与本特定系统有关的。

------------------------------------

在shell中输入man+数字+命令/函数即可以查到相关的命令和函数。若不加数字，那Linux man命令默认从数字较小的手册中寻找相关命令和函数。

例 如：我们输入man ls，它会在最左上角显示“LS（1）”，在这里，“LS”表示手册名称，而“（1）”表示该手册位于第一节章，同样，我们输入“man ifconfig”它会在最左上角显示“IFCONFIG（8）”。也可以这样输入命令：“man [章节号]手册名称”。

man是按照手册的章节号的顺序进行搜索的，比如：man sleep，只会显示sleep命令的手册,如果想查看库函数sleep，就要输入：man 3 sleep

------------------------------------

man -f command显示man程序的所有手册

例如：man -f kill

man n command显示指定章节的手册

man -a command显示所有章节的手册

man -w command显示手册所在的路径

man -aw command结合-a参数显示所有章节的手册路径

------------------------------------
```

- [详细介绍Linux man命令的使用方法](https://www.cnblogs.com/Jason-Ch/articles/2772973.html)


### ubuntu下靠谱的PHP软件源

[Ondřej Surý The main PPA for supported PHP versions with many](https://launchpad.net/~ondrej/+archive/ubuntu/php)