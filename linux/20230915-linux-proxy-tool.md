# Linux 下的代理工具  privoxy, proxychains, tor 
> privoxy, proxychains, tor 哪个更好用呢


## proxychains

现在一般用 proxychains-ng

https://github.com/rofl0r/proxychains-ng

ubuntu22.04自带这个， 但名字叫： proxychains4

```
==========================================
apt search proxychains-ng
正在排序... 完成
全文搜索... 完成  
libproxychains4/jammy 4.16-1 amd64
  runtime shared library for proxychains-ng

proxychains4/jammy 4.16-1 amd64
  redirect connections through socks/http proxies (proxychains-ng)

==========================================
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




