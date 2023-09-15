# Linux 下的代理工具  privoxy, proxychains, tor 
> privoxy, proxychains, tor 哪个更好用呢


## proxychains

现在一般用 proxychains-ng

https://github.com/rofl0r/proxychains-ng

ubuntu22.04自带这个， 但名字叫： proxychains4

```
# 查找软件包
apt search proxychains-ng
正在排序... 完成
全文搜索... 完成  
libproxychains4/jammy 4.16-1 amd64
  runtime shared library for proxychains-ng

proxychains4/jammy 4.16-1 amd64
  redirect connections through socks/http proxies (proxychains-ng)

# 查看软件包详情 确定是我们要找的ng版本
apt show proxychains4

Package: proxychains4
Version: 4.16-1
Priority: optional
Section: universe/net
Source: proxychains-ng
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Boyuan Yang <byang@debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 76.8 kB
Provides: proxychains, proxychains-ng
Depends: libproxychains4 (= 4.16-1), libc6 (>= 2.34)
Breaks: proxychains (<< 3.1-8)
Replaces: proxychains
Homepage: https://github.com/rofl0r/proxychains-ng
Download-Size: 18.4 kB
APT-Sources: http://cn.archive.ubuntu.com/ubuntu jammy/universe amd64 Packages
Description: redirect connections through socks/http proxies (proxychains-ng)
 Proxychains is a UNIX program, that hooks network-related libc functions
 in dynamically linked programs via a preloaded DLL (dlsym(), LD_PRELOAD)
 and redirects the connections through SOCKS4a/5 or HTTP proxies.
 It supports TCP only (no UDP/ICMP etc).
 .
 This project, proxychains-ng, is the continuation of the unmaintained
 proxychains project (known as proxychains package in Debian).
```

看下说明里的github地址， 的确是同一个项目，版本号都一样，直接安装就可以。

注意一下 apt search 命令会检索描述， 搜出的结果会比较多。 建议先用apt list 命令先按照软件名称搜索，搜索不到的话再用 apt search 搜索。

配置文件路径: /etc/proxychains4.conf

在配置文件末尾增加代理配置： socks5 127.0.0.1 7070

测试命令：proxychains curl www.google.com.hk， 的确可以正常使用

但是我使用 dep 更新信赖的时候会报错， 可能有兼容性问题， 有时间可以试下更改 proxy_dns 为 proxy_dns_old 。

总结： proxychains 配置比较简单， 一般命令行使用还是很方便的， 但是不支持域名白名单，只支持IP白名单，某些复杂的软件会有问题。

## privoxy

官方： https://www.privoxy.org/

```
#直接安装就可以
sudo apt install privoxy

#查看服务是否启动
systemctl status privoxy

● privoxy.service - Privacy enhancing HTTP Proxy
     Loaded: loaded (/lib/systemd/system/privoxy.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2023-09-15 11:21:42 CST; 10s ago
       Docs: man:privoxy(8)
             https://www.privoxy.org/user-manual/
    Process: 109749 ExecStart=/usr/sbin/privoxy --pidfile $PIDFILE --user $OWNER $CONFIGFILE (code=exited, status=0/SUCCESS)
   Main PID: 109752 (privoxy)
      Tasks: 1 (limit: 9324)
     Memory: 1.3M
     CGroup: /system.slice/privoxy.service
             └─109752 /usr/sbin/privoxy --pidfile /run/privoxy.pid --user privoxy /etc/privoxy/config

9月 15 11:21:41 liuyibao-ubuntu systemd[1]: Starting Privacy enhancing HTTP Proxy...
9月 15 11:21:42 liuyibao-ubuntu systemd[1]: Started Privacy enhancing HTTP Proxy.

#默认8118端口已经启动
netstat -an | grep 8118
tcp        0      0 127.0.0.1:8118          0.0.0.0:*               LISTEN     
tcp6       0      0 ::1:8118                :::*                    LISTEN
```
