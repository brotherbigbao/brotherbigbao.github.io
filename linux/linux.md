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


### ubuntu16.04无法使用add-apt-repository

```
apt-get install software-properties-common
```

### ubuntu命令行下中文问题 locale -a 看不到有中文 (阿里云默认会有这个问题)
```
apt install language-pack-zh-hans
```

### crontab注意事项
```
2. crontab与环境变量
不要假定cron知道所需要的特殊环境，它其实并不知道。所以你要保证在shelll脚本中提供所有必要的路径和环境变量，除了一些自动设置的全局变量。所以注意如下3点：
1）脚本中涉及文件路径时写全局路径；
2）脚本执行要用到java或其他环境变量时，通过source命令引入环境变量，如：
cat start_cbp.sh
#!/bin/sh
source /etc/profile
export RUN_CONF=/home/d139/conf/platform/cbp/cbp_jboss.conf
/usr/local/jboss-4.0.5/bin/run.sh -c mev &
3）当手动执行脚本OK，但是crontab死活不执行时。这时必须大胆怀疑是环境变量惹的祸，并可以尝试在crontab中直接引入环境变量解决问题。如：
0 * * * * . /etc/profile;/bin/sh /var/www/java/audit_no_count/bin/restart_audit.sh

3. 其他应该注意的问题
1）新创建的cron job，不会马上执行，至少要过2分钟才执行。如果重启cron则马上执行。
2）每条 JOB 执行完毕之后，系统会自动将输出发送邮件给当前系统用户。日积月累，非常的多，甚至会撑爆整个系统。所以每条 JOB 命令后面进行重定向处理是非常必要的： >/dev/null 2>&1 。前提是对 Job 中的命令需要正常输出已经作了一定的处理, 比如追加到某个特定日志文件。
3）当crontab突然失效时，可以尝试/etc/init.d/crond restart解决问题。或者查看日志看某个job有没有执行/报错tail -f /var/log/cron。
4）千万别乱运行crontab -r。它从Crontab目录（/var/spool/cron）中删除用户的Crontab文件。删除了该用户的所有crontab都没了。
5）在crontab中%是有特殊含义的，表示换行的意思。如果要用的话必须进行转义\%，如经常用的date ‘+%Y%m%d’在crontab里是不会执行的，应该换成date ‘+\%Y\%m\%d’`。
```

### 显示一个文件的某几行
```
linux 如何显示一个文件的某几行(中间几行)
【一】从第3000行开始，显示1000行。即显示3000~3999行
cat filename | tail -n +3000 | head -n 1000

【二】显示1000行到3000行
cat filename| head -n 3000 | tail -n +1000
*注意两种方法的顺序

分解：

    tail -n 1000：显示最后1000行

    tail -n +1000：从1000行开始显示，显示1000行以后的

    head -n 1000：显示前面1000行
    
【三】用sed命令
 sed -n '5,10p' filename 这样你就可以只查看文件的第5行到第10行。
```

> [原文](https://www.cnblogs.com/xianghang123/archive/2011/08/03/2125977.html)


### 统计目录及子目录所有文件代码行数

```
find . -name '*.php' | xargs wc -l
```

> [原文](https://stackoverflow.com/questions/1358540/how-to-count-all-the-lines-of-code-in-a-directory-recursively?page=1&tab=votes#tab-top)


### xargs

xargs命令是给其他命令传递参数的一个过滤器，也是组合多个命令的一个工具。它擅长将标准输入数据转换成命令行参数，

xargs能够处理管道或者stdin并将其转换成特定命令的命令参数。xargs也可以将单行或多行文本输入转换为其他格式，例如多行变单行，

单行变多行。xargs的默认命令是echo，空格是默认定界符。这意味着通过管道传递给xargs的输入将会包含换行和空白，

不过通过xargs的处理，换行和空白将被空格取代。xargs是构建单行命令的重要组件之一。

[原文](http://man.linuxde.net/xargs)


### 9 Bash Aliases to Make Your Life Easier

[9 Bash Aliases to Make Your Life Easier](9-bash-aliases-to-make-your-life-easier.md)