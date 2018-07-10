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