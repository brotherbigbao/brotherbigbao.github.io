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